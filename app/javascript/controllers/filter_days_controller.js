// import { Controller } from "stimulus"

// export default class extends Controller {
//   static targets = ["results"]

//   connect() {
//     console.log("Connected to SearchController")
//   }

//   searchBy7Days() {
//     const url = "/expenses"
//     fetch(url, { headers: { "X-Requested-With": "XMLHttpRequest" } })
//       .then(response => response.text())
//       .then(html => {
//         this.resultsTarget.innerHTML = html
//       })
//   }
// }
