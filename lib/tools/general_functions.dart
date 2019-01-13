String addZeroes(int number) {
	String num = number.toString();
  if (num.length == 1) {
    return '00'+num;
  } else if (num.length == 2) {
    return '0'+num;
  }

  return num;
}