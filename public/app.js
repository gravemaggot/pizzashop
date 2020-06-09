function something() 
{
    var x = window.localStorage.getItem('x');

    x = x + 1;

    window.localStorage.setItem('x', 555);

    alert(x);

    for (var i = 0; i < localStorage.length; i++){
        $('body').append(localStorage.getItem(localStorage.key(i)));
    }
}