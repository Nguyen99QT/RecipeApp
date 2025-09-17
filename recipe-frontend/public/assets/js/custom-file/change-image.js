
// $(document).ready(function() {

//     // Assuming your file input has the id "imageInput"
//     $('#imageInput').change(function() {
//       let input = this;

//       if (input.files && input.files[0]) {
//         let reader = new FileReader();

//         reader.onload = function(e) {
//           // Update the src attribute of the image with the new data URL
//           $('#previewImage').attr('src', e.target.result);
//         };

//         reader.readAsDataURL(input.files[0]);
//       }
//     });
//   });


$(document).ready(function () {
    // Assuming your file input has the id "imageInput"
    $('#imageInput').change(function () {
        let input = this;
        console.log("input:", input);
        if (input.files && input.files[0]) {
            let reader = new FileReader();

            reader.onload = function (e) {
                // Update the src attribute of the image with the new data URL
                $('#previewImage').attr('src', e.target.result);

                // Update the background-image of the image-input-outline div
                $('.image-input-outline').css('background-image', 'url(' + e.target.result + ')');
            };

            reader.readAsDataURL(input.files[0]);
        }
    });
});


//
function previewFile(inputElement) {
    const index = inputElement.getAttribute('data-index');
    const preview = document.getElementById('previewImage' + index);
    const file = inputElement.files[0];
    const reader = new FileReader();

    reader.addEventListener("load", function () {
        // Convert image file to base64 string and update the preview
        preview.src = reader.result;
    }, false);

    if (file) {
        reader.readAsDataURL(file);
    }
}






