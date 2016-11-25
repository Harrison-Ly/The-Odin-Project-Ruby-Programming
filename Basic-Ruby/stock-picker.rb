def stock_picker(dayPrices)
  bestBuyDay = 0
  bestSellDay = 1
  profit = 0

  buyDay = 0

  while buyDay < dayPrices.length do
    sellDay = buyDay + 1
    while sellDay < dayPrices.length do
      newProfit =  dayPrices[sellDay] - dayPrices[buyDay]
      if newProfit > profit
        profit = newProfit
        bestBuyDay = buyDay
        bestSellDay = sellDay
      end
      sellDay += 1
    end
    buyDay += 1
  end
  puts "Best day to buy is day #{bestBuyDay.to_s} \nBest day to sell is day #{bestSellDay.to_s}"
  puts "Total profit is #{profit}"
end

#test
stock_picker([17,3,6,9,15,8,6,1,10]) #answer 1,4
