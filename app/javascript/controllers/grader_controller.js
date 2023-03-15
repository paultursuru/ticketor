import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="grader"
export default class extends Controller {
  static targets = [ "grade", "form", "number"]

  grading(event) {
    this.toggleNumbers(event)
    let grade = event.currentTarget.dataset.grade
    let path = event.currentTarget.dataset.url
    let url = `${path}?grade=${grade}`
    fetch(url, {
      headers: { "Accept": "application/json" }
    }).then(response => response.json())
      .then(data => this.injectSpan(data, path))
  }

  toggleNumbers(event) {
    this.numberTargets.forEach(element => {
      if (element == event.currentTarget) {
        element.classList.add("bg-purple-900")
        element.classList.add("text-purple-100")
        element.classList.remove("bg-purple-100")
        element.classList.remove("text-purple-700")
      } else {
        element.classList.add("bg-purple-100")
        element.classList.add("text-purple-700")
        element.classList.remove("bg-purple-900")
        element.classList.remove("text-purple-100")
      }
    });
  }

  injectSpan(data, path) {
    if (data.grade === null) {
      this.gradeTarget.innerHTML = ``
    } else {
      this.gradeTarget.innerHTML = `<span class="h-10 w-10 bg-purple-100 absolute flex justify-center items-center text-purple-900 border-2 border-purple-500 rounded-full z-10 group-hover/grade:-z-10">
          ${data.grade}
        </span>
        <span data-grade="nil" data-url="${path}" data-action="click->grader#grading" class="h-10 w-10 bg-red-900 absolute flex justify-center items-center text-red-100 border-2 border-red-100 rounded-full ">
      x
      </span >`
    }
  }
}
