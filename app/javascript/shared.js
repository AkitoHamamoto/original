function menu (){

  const pullDownButton = document.getElementById("menu-lists")
  const menu = document.getElementById("menu")

  pullDownButton.addEventListener('mouseover', function(){
    menu.setAttribute("style","display: block" )
  })

  pullDownButton.addEventListener('mouseout', function(){
    menu.setAttribute("style","display: none" )
  })

}

setInterval(menu, 1000)