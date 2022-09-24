import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    console.log("rating controller")
  }

  getValue() {
    console.log("This is were values will be")
  }
}
