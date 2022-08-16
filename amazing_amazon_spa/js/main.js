const base_url = "http://localhost:3000/api/v1";
const fetch_all_products = fetch(`${base_url}/products`)
.then(res => res.json())


const products_container = document.querySelector('.products-container')

document.addEventListener('DOMContentLoaded', event => {
    fetch_all_products
    .then(products => {
        products_container.innerHTML = products.map(p => {
        return `
        <div class="item-container">
        <div class="card mb-3 index-card">
        <img src="/app/assets/images/${p.image_file}" class="card-img-top" alt="...">
        <div class="card-body">
        <h2 class="title-list-item card-title"><a style="color:rgb(158, 158, 241);font-size:1.5em;" class="product-link" data-id="${p.id}" href="#">${p.title}</a></h2>
        <p class="card-text">${p.description}</p>
        <p class="card-text">$${p.price}</p>
        </div>
        </div>
        </div>
        `
        }).join('')
    })
})

const single_product_container = document.querySelector('.single-product')

products_container.addEventListener('click', event => {
    event.preventDefault()
    if(event.target.matches('.product-link')){
        const product_id = event.target.dataset.id
        fetch(`${base_url}/products/${product_id}`)
        .then(
            res => res.json()
        )
        .then(({id, title, description, price, reviews, image_file})=>{
            single_product_container.innerHTML = `
                <img src="/app/assets/images/${image_file}" class="card-img-top" alt="...">
                <div class="card-body">
                <h2 class="card-title" style="color:rgb(158, 158, 241);font-weight: bold;">${title}</h2>
                <p class="card-text">${description}</p>
                <p class="card-text">$${price}</p>
                </div>
            `;
            const reviews_html = reviews.map(r => {
                return `<p class="card-text">${r.body}</p>`
            }).join('')
            single_product_container.innerHTML += '<h2 class="mx-3" style="color:rgb(158, 158, 241);font-weight: bold;">Reviews</h2>'
            single_product_container.innerHTML += ('<div class="card-body">'+reviews_html+'</div>');
            products_container.hidden = true
            single_product_container.hidden = false
        })
    }
})

const navbar = document.querySelector('.navbar')
navbar.addEventListener('click', event => {
    
    const nav_link = event.target.closest('a')
    if(nav_link){
        event.preventDefault()
        const div_class = nav_link.dataset.target
        document.querySelectorAll('.page').forEach(page => {
            page.hidden = true
        })
        document.querySelector(`.${div_class}`).hidden = false
    }
})