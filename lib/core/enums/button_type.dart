enum ButtonType {
  save,
  submit,
  update,
  delete,
}

extension ButtonTypeExtention on ButtonType {
  String get name {
    switch (this) {
      case ButtonType.save:
        return "저장";
      case ButtonType.submit:
        return "등록";
      case ButtonType.update:
        return "수정";
      case ButtonType.delete:
        return "삭제";
    }
  }
}
