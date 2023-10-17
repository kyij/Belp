'use strict';
//Create unique button for locations in locations.html

const favlocationsButtonlist = document.querySelectorAll('.favlocation');
for (const button of favlocationsButtonlist) {
    button.addEventListener('click', (evt) => {
        evt.preventDefault;
        alert('You have saved this location to match with!');
        let locationid = button.id
        fetch('/savelocation', {
            method: 'POST',
            body: JSON.stringify({locationid}),
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


