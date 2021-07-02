const showDialog = (content, modal_id) => {
  const modalElements = /*html */ `
      <div id="${modal_id}" class="modal">
          <div class="modal-content">
              ${content}
          </div>
      </div>
     `;
  var div = document.createElement("div");
  div.innerHTML = modalElements.trim();
  document.body.appendChild(div.firstChild);
};

const showYesNoDialog = (
  header,
  content,
  yes_text,
  no_text,
  yes_action,
  modal_id
) => {
  const yesBtn =
    yes_text !== ""
      ? `<button class="btn-small" onclick="closeModal('${modal_id}');${yes_action}">${yes_text}</button>`
      : "";
  const noBtn =
    no_text !== ""
      ? `<button class="btn-small" onclick="closeModal('${modal_id}')">${no_text}</button>`
      : "";
  const modal_content = /*html */ `
    <div class="modal-header">${header}</div>
    <div class="modal-main">${content}</div>
    <div class="modal-actions">
        ${yesBtn}${noBtn}
    </div>
    `;

  showDialog(modal_content, modal_id);
};

const closeModal = (modal_id) => {
  document.getElementById("" + modal_id).remove();
};
