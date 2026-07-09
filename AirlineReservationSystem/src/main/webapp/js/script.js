/* =========================================================
   Airline Reservation System - Main JavaScript
   ========================================================= */

document.addEventListener('DOMContentLoaded', function () {

    // ---- Auto-dismiss alerts after 5 seconds ----
    var alerts = document.querySelectorAll('.alert-auto-dismiss');
    alerts.forEach(function (alertEl) {
        setTimeout(function () {
            alertEl.style.transition = 'opacity 0.5s ease';
            alertEl.style.opacity = '0';
            setTimeout(function () { alertEl.remove(); }, 500);
        }, 5000);
    });

    // ---- Prevent past dates in date inputs ----
    var dateInputs = document.querySelectorAll('input[type="date"]');
    var today = new Date().toISOString().split('T')[0];
    dateInputs.forEach(function (input) {
        if (!input.hasAttribute('min')) {
            input.setAttribute('min', today);
        }
    });

    // ---- Swap source / destination on search form ----
    var swapBtn = document.getElementById('swapLocationsBtn');
    if (swapBtn) {
        swapBtn.addEventListener('click', function () {
            var source = document.getElementById('source');
            var destination = document.getElementById('destination');
            var temp = source.value;
            source.value = destination.value;
            destination.value = temp;
        });
    }

    // ---- Registration form: confirm password match ----
    var registerForm = document.getElementById('registerForm');
    if (registerForm) {
        registerForm.addEventListener('submit', function (e) {
            var password = document.getElementById('password').value;
            var confirmPassword = document.getElementById('confirmPassword').value;
            if (password !== confirmPassword) {
                e.preventDefault();
                showInlineError('confirmPasswordError', 'Passwords do not match.');
            }
        });
    }

    // ---- Booking form: recalculate total price when seat count changes ----
    var numSeatsInput = document.getElementById('numSeats');
    var pricePerSeatEl = document.getElementById('pricePerSeat');
    var totalAmountEl = document.getElementById('totalAmountDisplay');
    if (numSeatsInput && pricePerSeatEl && totalAmountEl) {
        var pricePerSeat = parseFloat(pricePerSeatEl.dataset.price);
        var updateTotal = function () {
            var seats = parseInt(numSeatsInput.value, 10) || 1;
            var total = (seats * pricePerSeat).toFixed(2);
            totalAmountEl.innerText = 'Rs. ' + total;
        };
        numSeatsInput.addEventListener('input', updateTotal);
        updateTotal();
    }

    // ---- Payment form: format card number with spaces ----
    var cardNumberInput = document.getElementById('cardNumber');
    if (cardNumberInput) {
        cardNumberInput.addEventListener('input', function () {
            var digits = cardNumberInput.value.replace(/\D/g, '').substring(0, 16);
            var groups = digits.match(/.{1,4}/g);
            cardNumberInput.value = groups ? groups.join(' ') : digits;
        });
    }

    // ---- Payment form: only allow digits in CVV ----
    var cvvInput = document.getElementById('cvv');
    if (cvvInput) {
        cvvInput.addEventListener('input', function () {
            cvvInput.value = cvvInput.value.replace(/\D/g, '').substring(0, 3);
        });
    }

    // ---- Bootstrap form validation styling ----
    var formsToValidate = document.querySelectorAll('.needs-validation');
    Array.prototype.slice.call(formsToValidate).forEach(function (form) {
        form.addEventListener('submit', function (event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add('was-validated');
        }, false);
    });
});

/**
 * Displays an inline error message in the element with the given id.
 */
function showInlineError(elementId, message) {
    var el = document.getElementById(elementId);
    if (el) {
        el.innerText = message;
        el.style.display = 'block';
    }
}

/**
 * Displays a confirmation dialog before cancelling a booking.
 * Used on my-bookings.jsp cancel buttons.
 */
function confirmCancelBooking(pnr) {
    return confirm('Are you sure you want to cancel booking ' + pnr + '? This action cannot be undone.');
}

/**
 * Displays a confirmation dialog before deleting a flight.
 * Used on admin/manage-flights.jsp delete buttons.
 */
function confirmDeleteFlight(flightNumber) {
    return confirm('Are you sure you want to delete flight ' + flightNumber + '? This action cannot be undone.');
}
