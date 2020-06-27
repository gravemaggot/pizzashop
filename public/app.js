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

    window.localStorage.setItem(key, qty);

    update_orders_input();
    update_orders_button();

}

function update_orders_button()
{
    var text = 'Cart (' + cart_get_number_of_items() + ')';
    $('#orders_button').val(text);
}

function cart_get_number_of_items()
{
    var cnt = 0;

    for(var i = 0; i < window.localStorage.length; i++){
        key = window.localStorage.key(i);
        val = window.localStorage.getItem(key);

        if (key.indexOf('product_') >= 0){
            cnt = cnt + Number(val);
        }
    }

    return cnt;
}

function update_orders_input()
{
    var orders = cart_get_orders();
    $('#orders_input').val(orders);
}

function cart_get_orders()
{
    var orders = "";

    for(var i = 0; i < window.localStorage.length; i++){
        key = window.localStorage.key(i);
        val = window.localStorage.getItem(key);

        if (key.indexOf('product_') >= 0){
            orders = orders + key + "=" + val + ",";
        }
    }

    return orders;
}