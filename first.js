// * HERE'S VARIABLES YOU CAN COSTUMIZE
// let prices = [ 3, 12, 0, 9, 2, 7, 50, 77, 99, 4, 13, 50, 80 ]; // ! UNACCEPTABLE PRICES
// let prices = [ 3, 12, 1, 9, 2, 7, 50, 77, 99, 4, 13, 50, 'FIKRY' ]; // ! UNACCEPTABLE PRICES
let prices = [ 3, 12, 1, 9, 2, 7, 50, 77, 99, 4, 13, 50, 80 ]; // * ACCEPTABLE PRICES
let maxPurchases = 5;

// * GETTING READY TO GO
maxProfit(prices, maxPurchases, (err, profit, currentPurchases, details) => {
	// ! CATCH THE ERROR IF ANY
	if (err) throw err;

	console.log('Profit: ' + profit);
	console.log('Times of purchase: ' + currentPurchases);
	console.log('Purchase details: ', details);
});

// * NEVERMIND, IT'S JUST A TINY KITCHEN THO.
function maxProfit(prices = [], maxPurchases = 0, done) {
	// ! ABORT IF THE INPUT IS INVALID
	if (!prices || !maxPurchases || Math.min(...prices) <= 0 || prices.some(isNaN)) {
		done(Error('Invalid input'));
	}

	// * HELPER VARIABLES
	let isHoldingStocks = false; // * BOOLEAN WHETHER THERE'S STOCK BEING HOLD OR NOT
	let heldIndex = -1; // * INDEX OF THE STOCK IN HAND
	let currentPurchases = 0; // * COUNTER OF PURCHASE THAT HAS BEEN MADE

	// * OUTPUT VARIABLES
	let profit = 0;
	let details = [];

	for (let i = 0; i < prices.length; i++) {
		// ! BREAK THE LOOP IF THERE'S NO PURCHASE CHANCE LEFT
		if (currentPurchases === maxPurchases && !isHoldingStocks) break;

		// * MAKE A NEW PURCHASE IF:
		// * THERE'S NO STOCK IN HAND, AND
		// * THE NEXT PRICE IS HIGHER, AND
		// * STILL HAVE A CHANCE TO BUY.
		if (!isHoldingStocks && prices[i] < prices[i + 1]) {
			heldIndex = i;
			currentPurchases++;
			isHoldingStocks = true;
		}

		// * SELL THE STOCK IN HAND IF:
		// * THERE'S A STOCK IN HAND, AND
		// * THE NEXT PRICE IS GETTING LOWER, OR
		// * THE NEXT PRICE IS LOWER THAN BUY PRICE, OR
		// * CURRENT LOOP IS THE LAST ONE
		if (
			isHoldingStocks &&
			(prices[heldIndex] > prices[i + 1] || prices[i] > prices[i + 1] || i === prices.length - 1)
		) {
			let currentProfit = prices[i] - prices[heldIndex];
			profit += currentProfit;
			details.push({ buy: prices[heldIndex], sell: prices[i], profit: currentProfit });
			heldIndex = -1;
			isHoldingStocks = false;
		}
	}
	done(null, profit, currentPurchases, details);
}
