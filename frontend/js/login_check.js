if (localStorage.getItem("user") !== null) {
  console.log("is logged in");
  const item = document.getElementsByClassName("nav-group-authentication")[0];
  item.style.display = "none";
}
