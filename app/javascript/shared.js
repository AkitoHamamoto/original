function menu (){

  const pullDownButton = document.getElementById("menu-lists")
  const menu = document.getElementById("menu")

  pullDownButton.addEventListener('mouseover', function(){
    menu.setAttribute("style","display: block" )
    // menu.animate({opacity: '0'}, {opacity: '1'}, 1500)
  })

  pullDownButton.addEventListener('mouseout', function(){
    menu.setAttribute("style","display: none" )
  })

}

setInterval(menu, 1000)