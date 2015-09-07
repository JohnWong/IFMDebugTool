$(document).ready(function() {
  +function renderData(items, parentId, container) {
    for (var index in items) {
      var item = items[index];
      container.append("<tr data-tt-id='" + item.iden + "'" + (parentId?" data-tt-parent-id='" + parentId + "'":"") + "><td><span class='" + (item.type == "d"? "folder": "file") + "'>" + item.name + "</span></td><td>" + (item.type == "d"? "Folder": "File") + "</td><td>" + (item.size? item.size: "--") + "</td></tr>");
      renderData(item.subs, item.iden, container);
    }
  }(data, null, $("#example-advanced tbody"))

  $("#example-advanced").treetable({
    expandable: true
  });

  // Highlight selected row
  $("#example-advanced tbody").on("click", "tr", function() {
    $(".selected").not(this).removeClass("selected");
    var $this = $(this);
    if ($this.hasClass("selected")){
      if ($this.hasClass("leaf")) {
        if ($this.find("span[class=folder]").length == 0) {
          window.open ('/show1?id=' + encodeURI($this.data("ttId")), 'newwindow');
        }
      } else {
        $("#example-advanced").treetable("expandNode", $this.data("ttId"));
      }
    }
    $(this).addClass("selected");
  });

});