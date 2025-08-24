import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/utils/service_locator.dart';
import '../../../../employee/data/models/employees_model.dart';
import '../../../../employee/data/repos/employee_repo_impl.dart';

class SecretaryPickerField extends StatefulWidget {
  final int? initialSecretaryId;
  final String? initialSecretaryName;
  final String label;
  final ValueChanged<Employee> onSelected;
  final FormFieldValidator<String>? validator;

  const SecretaryPickerField({
    super.key,
    required this.onSelected,
    this.initialSecretaryId,
    this.initialSecretaryName,
    this.label = 'Secretary',
    this.validator,
  });

  @override
  State<SecretaryPickerField> createState() => _SecretaryPickerFieldState();
}

class _SecretaryPickerFieldState extends State<SecretaryPickerField> {
  final _controller = TextEditingController();
  Employee? _selected;

  @override
  void initState() {
    super.initState();
    if (widget.initialSecretaryName != null) {
      _controller.text = widget.initialSecretaryName!;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _openPicker() async {
    final picked = await showModalBottomSheet<Employee>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => const _SecretaryPickerSheet(),
    );
    if (picked != null) {
      setState(() {
        _selected = picked;
        _controller.text = picked.name;
      });
      widget.onSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: widget.label,
        suffixIcon: const Icon(Icons.person_search_rounded),
      ),
      validator: (v) => widget.validator?.call(v),
      onTap: _openPicker,
    );
  }
}

class _SecretaryPickerSheet extends StatefulWidget {
  const _SecretaryPickerSheet();

  @override
  State<_SecretaryPickerSheet> createState() => _SecretaryPickerSheetState();
}

class _SecretaryPickerSheetState extends State<_SecretaryPickerSheet> {
  final _search = TextEditingController();
  final _repo = getIt.get<EmployeeRepoImpl>();
  Timer? _debounce;
  bool _loading = true;
  List<Employee> _results = [];

  @override
  void initState() {
    super.initState();
    _loadInitial();
    _search.addListener(_onChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _search.removeListener(_onChanged);
    _search.dispose();
    super.dispose();
  }

  void _onChanged() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      final q = _search.text.trim();
      if (q.isEmpty) {
        _loadInitial();
      } else {
        setState(() => _loading = true);
        try {
          final found = await _repo.search(q);
          _setResults(found);
        } finally {
          if (mounted) setState(() => _loading = false);
        }
      }
    });
  }

  Future<void> _loadInitial() async {
    setState(() => _loading = true);
    try {
      final page = await _repo.fetchAll(page: 1);
      _setResults(page.data);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _setResults(List<Employee> employees) {
    final secs = employees.where((e) => e.role.toLowerCase().contains('secret')).toList();
    _results = secs;
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    final loc = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _search,
                decoration: InputDecoration(
                  labelText: loc.translate('Search secretary'),
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
              SizedBox(height: 12.h),
              if (_loading)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (_results.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Center(child: Text(loc.translate('No secretaries found'))),
                )
              else
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: _results.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (ctx, i) {
                      final e = _results[i];
                      return ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(e.name),
                        subtitle: Text(e.email),
                        trailing: Text('#${e.id}'),
                        onTap: () => Navigator.pop(context, e),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
