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

function add_to_cart(id)
{
    var key = 'product_' + id;
    
    var qty = window.localStorage.getItem(key);
    qty = qty * 1 + 1;
    window.localStorage.setItem(key + id, qty);
}