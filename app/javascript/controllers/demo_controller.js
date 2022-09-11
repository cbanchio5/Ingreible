import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal"];

  connect() {
    console.log(this.modalTarget)
  }

  launchDemo() {
    let modalController = this.application.getControllerForElementAndIdentifier(
      this.modalTarget,
      "modal"
  );
  modalController.open();
  }
}
