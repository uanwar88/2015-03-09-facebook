window.onload = function() {
  var links = document.getElementsByClassName('like-links');

  function create_new_element(liked_text) {
    new_strong_element = document.createElement("strong");
    text_node = document.createTextNode(liked_text);
    new_strong_element.appendChild(text_node);
  }

  function remove_like_link(num) {
    var like_div = document.getElementById("like-div-" + num)
    var link_id = "like-link-" + num;
    var link = document.getElementById(link_id);
    like_div.removeChild(link);
  }

  function display_new_likes(result) {
    var span_id = "likes-span-" + result["post_id"];
    var likes_span = document.getElementById(span_id);
    remove_like_link(result["post_id"]);
    likes_span.removeChild(likes_span.childNodes[1]);
    create_new_element("You like this post! " + result["new_number_of_likes"] + " likes");
    likes_span.appendChild(new_strong_element);
  }

  function like() {
    var url = this.getAttribute("data");
    js_req = new XMLHttpRequest();
    js_req.open("get", url);
    js_req.send();
    js_req.addEventListener("load", function() {
      result = JSON.parse(js_req.response);
      display_new_likes(result);
    });
  }

  for (var i = 0; i < links.length; i++) {
    links[i].addEventListener("click", like);
  }
}
