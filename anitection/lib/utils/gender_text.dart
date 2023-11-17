
String convertGenderText(String sourceGender) {
  switch(sourceGender) {
    case "male":
      return "♂";
    case "female":
      return "♀";
    default:
      return sourceGender;
  }
}