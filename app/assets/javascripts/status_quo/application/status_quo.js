$(function() {
  var renderContent = function(comments) {
    // templayed()
    //

    var template = '\
      <h1>{{segment}} Event Info</h1>\
      <button class="close"></button>\
      <div class="wrapper">\
        <div class="main">\
          <span>Event Information</span><br>\
          <span>Monday, October 21, 2015</span><br>\
          <strong>09.15 Universal Time</strong><br>\
          <strong>Status: {{status}}</strong>\
        </div>\
      </div>\
      <div class="button-container">\
        <button class="next"><strong>NEXT</strong></button>\
      </div>\
    ';
    var html = templayed(template)(comments);
    return $(html);
  };



  $('td.status div[data-comments]').each(function() {
    var self = $(this), content = renderContent($(this).data('comments'));
    content.on('click', 'button.close', function() {
      self.tooltipster('hide');
    });
    // content.on('click', 'button.next' function(event) {
    //   var
    //   self.tooltipster();
    // });
    $(this).tooltipster({
      content: content,
      theme: 'tooltipster-status_quo',
      animation: 'slide',
      autoClose: false,
      delay: 500,
      arrow: true,
      position: 'right',
      positionTracker: true,
      interactive: true
    });
  });
});

// $(function() {
//   $('td.status div').each(function() {
//     var content = $('\
//       <div>\
//         hello! jyrtjrd:)\
//       </div>\
//     ');
//     $(this).tooltipster({
//       content: content,
//       theme: 'tooltipster-punk'
//     });
//   });
// });
