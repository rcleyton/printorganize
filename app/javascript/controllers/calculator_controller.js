import { Controller } from "@hotwired/stimulus"

const MINUTES_PER_HOUR = 60;
const GRAMS_PER_KILOGRAM = 1000;

export default class extends Controller {
  static targets = [ 
    // Inputs
    "filament_price", 
    "filament_weight", 
    "printing_hours",
    "printing_minutes",
    "kilowatt_hour",
    "kilowatt_price",
    "maintenance",
    "value_hour_worked",
    "hour_worked",
    "packaging",
    "marketplace_fee",
    "fixed_marketplace_fee",
    "shipping",
    "profit_margin",

    // Outputs
    "suggested_price",
    "net_profit",
    "result_filament_cost",
    "result_energy_cost",
    "total_maintenance",
    "total_hour_worked",
    "total_packaging",
    "total_production_cost",
    "result_profit",
    "final_shipping",
    "final_fixed_marketplace_fee",
    "final_marketplace_fee",
    "final_price"
  ]

  connect() {
    this.calculate();
  }

  calculate() {
    const filamentCost = this.calculateFilamentCost();
    const energyCost = this.calculateEnergyCost();
    const maintenanceCost = this.calculateMaintenanceCost();
    const laborCost = this.calculateLaborCost();
    const packagingCost = this.calculatePackagingCost();

    // Production Cost
    const productionCost = filamentCost + energyCost + maintenanceCost + laborCost + packagingCost;
    this.total_production_costTarget.textContent = this.currency(productionCost);

    // Margem de lucro desejada (%)
    const profitMarginPercent = this.number(this.profit_marginTarget) / 100;
    const profitAmount = productionCost * profitMarginPercent;
    this.result_profitTarget.textContent = this.currency(profitAmount);

    // Frete
    const shippingCost = this.number(this.shippingTarget);
    this.final_shippingTarget.textContent = this.currency(shippingCost);

    // Taxa fixa do marketplace
    const fixedMarketplaceFee = this.number(this.fixed_marketplace_feeTarget);
    this.final_fixed_marketplace_feeTarget.textContent = this.currency(fixedMarketplaceFee);

    // Taxa percentual do marketplace (%)
    const marketplaceFeePercent = this.number(this.marketplace_feeTarget) / 100;

    // Cálculo do preço final sugerido P
    // P = ((Custo de Produção + Valor da Margem) + Taxa Fixa + Frete) / (1 - Taxa Percentual)
    const costWithProfitAndExpenses = (productionCost + profitAmount) + fixedMarketplaceFee + shippingCost;
    
    let suggestedPrice = 0;
    if (marketplaceFeePercent < 1) {
      suggestedPrice = costWithProfitAndExpenses / (1 - marketplaceFeePercent);
    } else {
      suggestedPrice = costWithProfitAndExpenses;
    }
    
    // Taxa de marketplace calculada
    const finalMarketplaceFee = suggestedPrice * marketplaceFeePercent;
    this.final_marketplace_feeTarget.textContent = this.currency(finalMarketplaceFee);

    // Lucro Líquido Real = Preço Final - Custo de Produção - Frete - Taxas do Marketplace
    const netProfit = suggestedPrice - productionCost - shippingCost - fixedMarketplaceFee - finalMarketplaceFee;
    
    // Exibição dos preços finais
    this.suggested_priceTarget.textContent = this.currency(suggestedPrice);
    this.final_priceTarget.textContent = this.currency(suggestedPrice);
    this.net_profitTarget.textContent = this.currency(netProfit);
  }
  
  printingTimeInHours(hours, minutes = 0) {
    return hours + (minutes / MINUTES_PER_HOUR);
  }

  calculateFilamentCost() {
    const filamentPrice = this.number(this.filament_priceTarget);
    const filamentWeight = this.number(this.filament_weightTarget);
    const filamentCost = (filamentWeight / GRAMS_PER_KILOGRAM) * filamentPrice;

    this.result_filament_costTarget.textContent = this.currency(filamentCost);
    return filamentCost;
  }

  calculateEnergyCost() { 
    const printingHours = this.number(this.printing_hoursTarget);
    const printingMinutes = this.number(this.printing_minutesTarget);
    const kilowattHour = this.number(this.kilowatt_hourTarget);
    const kilowattPrice = this.number(this.kilowatt_priceTarget);
    const printingTime = this.printingTimeInHours(printingHours, printingMinutes);
    const energyCost = kilowattHour * printingTime * kilowattPrice;

    this.result_energy_costTarget.textContent = this.currency(energyCost);
    return energyCost;
  }

  calculateMaintenanceCost() {
    const valueMaintenanceHour = this.number(this.maintenanceTarget);
    const printingHours = this.number(this.printing_hoursTarget);
    const printingMinutes = this.number(this.printing_minutesTarget);
    const printingTime = this.printingTimeInHours(printingHours, printingMinutes);
    const totalMaintenance = valueMaintenanceHour * printingTime;

    this.total_maintenanceTarget.textContent = this.currency(totalMaintenance);
    return totalMaintenance;
  }

  calculateLaborCost() {
    const valueHourWorked = this.number(this.value_hour_workedTarget);
    const hourWorked = this.number(this.hour_workedTarget);
    const totalHourWorked = valueHourWorked * hourWorked;

    this.total_hour_workedTarget.textContent = this.currency(totalHourWorked);
    return totalHourWorked;
  }

  calculatePackagingCost() {
    const valuePackaging = this.number(this.packagingTarget);
    this.total_packagingTarget.textContent = this.currency(valuePackaging);
    return valuePackaging;
  }

  reset() {
    const inputs = [
      this.filament_priceTarget,
      this.filament_weightTarget,
      this.printing_hoursTarget,
      this.printing_minutesTarget,
      this.kilowatt_hourTarget,
      this.kilowatt_priceTarget,
      this.maintenanceTarget,
      this.value_hour_workedTarget,
      this.hour_workedTarget,
      this.packagingTarget,
      this.marketplace_feeTarget,
      this.fixed_marketplace_feeTarget,
      this.shippingTarget,
      this.profit_marginTarget
    ];

    inputs.forEach(input => {
      input.value = 0;
    });

    this.calculate();
  }

  number(target) {
    return parseFloat(target.value) || 0;
  }

  currency(value) {
    return value.toLocaleString(
      "pt-BR",
      {
        style: "currency",
        currency: "BRL"
      }
    )
  }
}
