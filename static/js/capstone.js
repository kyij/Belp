'use strict';
//Create unique button for locations in locations.html

const favlocationsButtonlist = document.querySelectorAll('.favlocation');
for (const button of favlocationsButtonlist) {
    button.addEventListener('click', (evt) => {
        evt.preventDefault;
        alert('You have saved this location to match with!');
        let locationid = button.id
        let name = button.dataset.name
        let address = button.dataset.address
        let city = button.dataset.city
        let zip_code = button.dataset.zip_code
        let country = button.dataset.country
        let state = button.dataset.state
        let url = button.dataset.url
        let display_phone = button.dataset.display_phone
        let rating = button.dataset.rating
        let review_count = button.dataset.review


        fetch('/savelocation', {
            method: 'POST',
            body: JSON.stringify({locationid, name, address, city, zip_code, country, state, url, display_phone, rating, review_count}),
            headers: {
                'Content-Type': 'application/json',
            },
        })
            .then((response) => response.json())
            .then((responseJson) => {
                alert(responseJson.status);
            });

    })
};


