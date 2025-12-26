enum PopupActionsEnum {
  markAsDone(name: "Done | UnDone"),
  edit(name: "Edit"),
  delete(name: "Delete");

  final String name;
  const PopupActionsEnum({required this.name});
}
