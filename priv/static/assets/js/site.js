$(document).ready(function() {
    
    $('#form').submit(function (evt) {
        evt.preventDefault();
        window.history.back();
    });

    $("#submitButton").click(function(e) {

    var url = "/savejson"; // the script where you handle the form input.
    var postData = {
        name: "Don",
        email: "email",
        group: "group",
        homeCity: "city",
        funfact: "fact"
    }
    
    console.log(postData);
    
    $.ajax({
           type: "POST",
           url: url,
           data: JSON.stringify(postData),
           contentType: "application/json; charset=UTF-8",
           dataType: "json",
           success: function(data)
           {
               
                console.log('done');
               alert(data); // show response from the php script.
           }
         });

    e.preventDefault(); // avoid to execute the actual submit of the form.
});
    
});
