import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["link1", "link2", "link3", "link4", "link5"]

  connect() {
    console.log("rating controller")
  }

  getValue1() {
    console.log(this.link1Target.value * 1)
  }

  getValue2() {
    console.log(this.link2Target.value * 1)
  }

  getValue3() {
    console.log(this.link3Target.value * 1)
  }

  getValue4() {
    console.log(this.link4Target.value * 1)
  }

  getValue5() {
    console.log(this.link5Target.value * 1)
  }
}
