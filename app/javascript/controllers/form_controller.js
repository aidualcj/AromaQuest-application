import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["step", "answer", "form", "price"]

  connect() {
    this.showCurrentStep();
    this.updateProgressBar();
    this.initializeSlider();
  }

  selectAnswer(event) {
    event.preventDefault();
    const currentStep = this.currentStepIndex();
    const selectedAnswer = event.currentTarget.dataset.answer;

    this.answerTargets.forEach(button => button.classList.remove('clicked'));
    event.currentTarget.classList.add('clicked');

    this.addHiddenField(currentStep, selectedAnswer);
    if (currentStep < this.stepTargets.length - 1) {
      this.stepTargets[currentStep].classList.add("hidden");
      this.stepTargets[currentStep + 1].classList.remove("hidden");
      this.updateProgressBar();
    } else {
      // Affiche les valeurs des champs cachés avant la soumission du formulaire
      this.updatePriceField();
      this.formTarget.submit();
      // console.log("Champs cachés avant soumission :");
      // Array.from(this.formTarget.elements).forEach((element) => {
      //   if (element.type === "hidden") {
      //     console.log(`${element.name}: ${element.value}`);
      //   }
      // });
    }
  }

  previousStep(event) {
    event.preventDefault();
    const currentStep = this.currentStepIndex();
    if (currentStep > 0) {
      this.stepTargets[currentStep].classList.add("hidden");
      this.stepTargets[currentStep - 1].classList.remove("hidden");
      this.updateProgressBar();
    }
  }


  currentStepIndex() {
    return this.stepTargets.findIndex(step => !step.classList.contains("hidden"));
  }

  showCurrentStep() {
    this.stepTargets.forEach((step, index) => {
      if (index === 0) {
        step.classList.remove("hidden");
      } else {
        step.classList.add("hidden");
      }
    })
  }

  addHiddenField(stepIndex, answer) {
    const input = document.createElement("input");
    input.type = "hidden";
    input.name = `result[answer_${stepIndex + 1}]`;
    input.value = answer;
    this.formTarget.appendChild(input);
  }

  updateProgressBar() {
    const currentStep = this.currentStepIndex();
    const totalSteps = this.stepTargets.length;
    const progressPercent = (currentStep / (totalSteps - 1)) * 100;
    document.getElementById('progress-bar').style.width = `${progressPercent}%`;
  }

  initializeSlider() {
    const slider = document.querySelector('#myRange');
    if (slider) {
      slider.addEventListener('input', () => {
        this.updatePriceField();
      });
    }
  }

  updatePriceField() {
    const slider = document.querySelector('#myRange');
    const priceField = this.priceTarget;
    if (slider && priceField) {
      priceField.value = slider.value;
    }
  }
}
