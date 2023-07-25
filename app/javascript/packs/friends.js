let hide_spinner = function () {
  spinner = document.getElementById("spinner");
  spinner.style.display = "none";
};

let show_spinner = function () {
  spinner = document.getElementById("spinner");
  spinner.style.display = "block";
};

let init_friend_lookup;

init_friend_lookup = function () {
  const friendsForm = document.getElementById("friend-lookup-form");

  friendsForm.addEventListener("ajax:before", (event) => {
    show_spinner();
  });

  friendsForm.addEventListener("ajax:success", (event) => {
    const [data, status, xhr] = event.detail;
    const friendLookup = document.getElementById("friend-lookup");

    friendLookup.replaceWith(data.body);
    init_friend_lookup();
  });

  friendsForm.addEventListener("ajax:error", (event) => {
    const friendResults = document.getElementById("friend-lookup-results");
    const friendErrors = document.getElementById("friend-lookup-errors");

    hide_spinner();
    friendResults.replaceWith(" ");
    friendErrors.replaceWith("Person was not found.");
  });
};

document.addEventListener("DOMContentLoaded", () => {
  init_friend_lookup();
});
