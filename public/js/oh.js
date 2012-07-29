$(function() {
  $('#text').keydown(function() {
    var self = $(this);
    var text = self;
    if ('' == self.val().trim()) {
      return;
    }
    var suggest = $('#suggest');
    $.get(suggest.data('url'),
          {'for' : self.val()},
          function(data) {
            suggest.children().remove();
            var json = $.parseJSON(data);
            $.each(json.dajare, function(i, val) {
              suggest.append(['<li data-text="',  val.text, '">', '<a class="button" href="#">', val.text, '</a>', ' ', val.deta ? '(たぶん出た)' : '(たぶん出てない)', '</li>'].join(''));
              suggest.find('li').click(function() {
                var self = $(this);
                text.val(self.data('text'));
                $('#status').submit();
              });
            });
          });
  });
});