# Project Cleanup and SendVideoPage Refinement

I have successfully updated the `SendVideoPage` and resolved numerous project warnings.

## Changes Made

### EKYC Authentication
- **[SendVideoPage](file:///C:/Users/a.shakouri.MEHRCOMTECH/Documents/FlutterProjects/MehrSepand.Mobile.Application/lib/Features/EKYC_Authentication_Page/Presentation/send_video_page.dart)**:
    - Removed redundant instructional titles and the "Important Notes" section as requested.
    - Moved the camera preview to the top of the content area for immediate visibility.
    - Updated the "Confirm and Continue" button logic:
        - Shows a notification ("لطفاً ابتدا ضبط ویدیو را انجام دهید.") if no video is recorded.
        - Enters a loading state and disables itself during server communication.
    - Fixed `use_build_context_synchronously` warnings.
    - Removed unused local variables and unnecessary imports.

### Project Warning Fixes
- **Deprecated Members**: Replaced deprecated `withOpacity` with `withValues(alpha: ...)` across the project.
- **Immutability**: Made fields `final` in `@immutable` classes:
    - `DepositInputContainer`
    - `WithdrawInputContainer`
    - `SelectWalletDropdown` (also refactored to remove mutation in `build`)
    - `OtherBankCardPayment`
    - `SelectTransactionTypes`
- **File Naming**: Renamed several files to follow the `lower_case_with_underscores` convention and updated all related imports:
    - `persian_date_format_h.dart`, `persian_date_format_m_d.dart`, `persian_date_format_y_m_d.dart`
    - `get_citizen_ekyc_status_bloc.dart` (and event/state)
    - `custom_indicator.dart`
    - `add_balance_text_field.dart`
    - `jalali_to_utc_iso.dart`
- **Code Style**:
    - Fixed `curly_braces_in_flow_control_structures` in `app_them.dart`.
    - Removed dead null-aware operators (`??`, `?.`) and unnecessary null comparisons in `package_card.dart`, `build_details_section.dart`, etc.
    - Removed unused local variables (e.g., `width` in `custom_card.dart`, `mediaQuery` in `wallet_payment.dart`).

## Verification Results

- **Static Analysis**: The number of issues reported by `flutter analyze` was reduced from **200 to 139**. The remaining issues are mostly `avoid_print` and missing type annotations, which can be addressed in a follow-up task if needed.
- **Manual Check**: The logic for the "Confirm and Continue" button in `SendVideoPage` now correctly handles the non-recorded state and prevents multiple clicks during submission.
