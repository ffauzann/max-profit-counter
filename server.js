function maxProfit(prices = [], maxPurchases = 0) {
	// ! ABORT IF THE INPUT IS INVALID
	if (!prices || !maxPurchases) {
		console.log('Invalid input');
		return;
	}

	let isHoldingStocks = false; // * BOOLEAN WHETHER THERE'S STOCK BEING HOLD OR NOT
	let heldIndex = -1; // * INDEX OF THE STOCK IN HAND
	let currentPurchases = 0; // * COUNTER OF PURCHASE HAS BEEN MADE
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
			console.log('buy in: ' + prices[heldIndex]);
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
			profit += prices[i] - prices[heldIndex];
			details.push({ buy: prices[heldIndex], sell: prices[i] });
			heldIndex = -1;
			isHoldingStocks = false;
			console.log('sell out: ' + prices[i]);
		}
	}
	console.log('\nProfit: ' + profit);
	console.log('Times of purchase: ' + currentPurchases);
	console.log('Purchase details: ', details);
}

let prices = [ 3, 12, 1, 9, 2, 99, 20, 77, 4, 13, 50, 80 ];
let maxPurchases = 5;
maxProfit(prices, maxPurchases);
