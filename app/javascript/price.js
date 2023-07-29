window.addEventListener('turbo:load', () => {

  const priceInput = document.getElementById("item-price");
  const addTaxDom = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");

  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const salesFee = Math.floor(inputValue * 0.1);

    addTaxDom.innerHTML = salesFee;
    profit.innerHTML = inputValue - salesFee;
  });

});
