document.addEventListener('DOMContentLoaded', function () {
  Highcharts.addEvent(Highcharts.Series, 'legendItemClick', function (e) {
    var clickedName = this.name;
    var makeVisible = !this.visible; // estado al que queremos llevar todos

    Highcharts.charts.forEach(function(chart) {
      if (!chart) return;

      chart.series.forEach(function(s) {
        if (s.name === clickedName) {
          if (makeVisible) {
            s.show();
          } else {
            s.hide();
          }
        }
      });
    });

    return false; // <-- evita que el gráfico original haga su toggle propio
  });
});