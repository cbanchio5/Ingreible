import { Controller } from "stimulus";

export default class extends Controller {

  static targets = ["index", "content", "previous", "next"]
    initialize() {
      let step = this.indexTarget.innerText
      step = step.replace(/\D/g, '') * 1
      console.log(this.contentTarget.querySelectorAll('.step')[step -1])
      this.contentTarget.querySelectorAll('.step')[step -1].classList.remove('inactive--div')
      console.log(this.contentTarget.querySelectorAll('.step')[step -1])
      // if (step === 1) {
      //   this.previousTarget.setAttribute("disabled", "")
      //   this.contentTarget.querySelectorAll('p')[step -1].classList.remove('inactive--div')

      // } else {
      //   this.previousTarget.removeAttribute('disbaled')
      // }

    }

    open() {
      document.body.classList.add("modal-open");
      this.element.setAttribute("style", "display: block;");
      this.element.classList.add("show");
      document.body.innerHTML += '<div class="modal-backdrop fade show"></div>';
  }

  close() {
    document.body.classList.remove("modal-open");
    this.element.removeAttribute("style");
    this.element.classList.remove("show");
    document.getElementsByClassName("modal-backdrop")[0].remove();
}

  next() {


    let step = this.indexTarget.innerText
    let step_number = step.replace(/\D/g, '') * 1
    let next_step = step_number + 1
    step = step.replace("1", next_step)
    this.indexTarget.innerText = step



  }

  previous() {
    console.log("PREVIOUS")
  }
}
