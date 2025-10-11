import { Controller } from "@hotwired/stimulus"
// Connects to data-controller="user-auto-fill"
export default class extends Controller {
  static targets = ["field"]
  static values = { userData: Object }
  connect() {
    console.log("This is the autfill controller")
  }

  fill(event) {
    console.log("This is the fill function")
    const checkbox = event.currentTarget

    if (checkbox.checked) {
      this.fieldTargets.forEach(field => {
        const fieldName = field.dataset.userAutoFillFieldName
        field.value = this.userDataValue[fieldName]
      })
    }
    else {
      this.fieldTargets.forEach(field => {
        field.value = ""
      })
    }
  }
}
