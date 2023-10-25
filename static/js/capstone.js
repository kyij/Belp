'use strict';
//Create unique button for locations in locations.html

const favlocationsButtonlist = document.querySelectorAll('.favlocation');
for (const button of favlocationsButtonlist) {
    button.addEventListener('click', (evt) => {
        evt.preventDefault;
        alert('You have saved this location! Refer to your profile to see further details!');
        let locationid = button.id
        let name = button.dataset.name
        let address = button.dataset.address
        let city = button.dataset.city
        let zip_code = button.dataset.zip_code
        let country = button.dataset.country
        let state = button.dataset.state
        let url = button.dataset.url
        let display_phone = button.dataset.display_phone
        let img_url = button.dataset.img_url
        let rating = button.dataset.rating
        let review_count = button.dataset.review


        fetch('/savelocation', {
            method: 'POST',
            body: JSON.stringify({ locationid, name, address, city, zip_code, country, state, url, display_phone, img_url, rating, review_count }),
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


// const newPost = document.getElementById('create_post');
// newPost.addEventListener('submit', (evt) => {
//     evt.preventDefault();
//     alert("You have added a post!")
//     const formInputs = {
//         locationID: document.querySelector('#location_id').value,
//         post_body: document.querySelector('#posts_body').value,
//     };

//     fetch('/save_post', {
//         method: 'POST',
//         body: JSON.stringify(formInputs),
//         headers: {
//             'Content-Type': 'application/json',
//         },
//     })
//         .then((response) => response.json())
//         .then((responseJson) => {
//             alert(responseJson.status);
//             // location.href ="/"
//             window.location.reload(true);
// })
// });
