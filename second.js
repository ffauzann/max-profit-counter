const numbers = [ 1, 2, 3, 4, 5, 6, 7, 8, 9 ];

// * HERE'S VARIABLES YOU CAN COSTUMIZE
const shift = 12;

// * GETTING READY TO GO
arrayShifter(numbers, shift, (err, result) => {
	// ! CATCH THE ERROR IF ANY
	if (err) throw err;

	console.log('Result: ', result);
});

// * NEVERMIND, IT'S JUST A TINY KITCHEN THO.
function arrayShifter(numbers = [], shift = 0, done) {
	// ! ABORT IF THE INPUT IS INVALID
	if (!numbers || (!shift || shift <= 0 || isNaN(shift)) || numbers.some(isNaN)) {
		done(
			Error(`The input doesn't meet one or more conditions:\n
            1. Every element of numbers must be numeric value.\n
            2. Number of shift must have positive value.\n
            3. The elements of numbers can't be more or less than 9.`)
		);
	}

	// * HELPER VARIABLES
	let jumper = [ 1, 1, 3, -3, 0, 3, -3, -1, -1 ]; // * THIS IS VALUE OF HOW MANY STEP OF EACH ARRAY ELEMENT NEED TO MOVE
	let shiftedArr = []; // * USED TO ASSIGN EVERY LOOP OF SHIFT
	let finalShiftedArr = []; // * USED TO SEND FINAL SHIFTED ARRAY

	// * SHIFT LOOPER
	for (let i = 1; i <= shift; i++) {
		// * USED TO STORE TEMPORARY SHIFTED ARRAY
		let tmpShiftedArr = [];

		// * NUMBER LOOPER
		for (let j = 0; j < numbers.length; j++) {
			let newIndex = j + jumper[j];
			tmpShiftedArr[newIndex] = shiftedArr.length > 0 ? shiftedArr[j] : numbers[j];
			tmpShiftedArr.join();
		}

		// * ASSIGN THE TEMPORARY INTO SHIFTED ONE FOR THE NEXT SHIFT LOOP
		shiftedArr = tmpShiftedArr;
	}

	// * CALLBACK WITH A FINAL SHIFTED ARRAY
	finalShiftedArr = shiftedArr;
	done(null, finalShiftedArr);
}
