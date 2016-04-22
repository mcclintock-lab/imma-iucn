ReportTab = require 'reportTab'
templates = require '../templates/templates.js'
d3 = window.d3

class OverviewTab extends ReportTab
  name: 'Overview'
  className: 'overview'
  template: templates.overview
  dependencies:[ 
    'Size'
  ]
  render: () ->

    # create random data for visualization
    size = @recordSet('Size', 'Size').toArray()[0]
    console.log("org size: ", size)
    aoi_size = @addCommas Number(size.SIZE_IN_KM).toFixed(2)
    console.log("size: ", aoi_size)
    eezs = @recordSet('Size', 'EEZs').toArray()
    isCollection = @model.isCollection()

    # setup context object with data and render the template from it
    context =
      sketch: @model.forTemplate()
      sketchClass: @sketchClass.forTemplate()
      attributes: @model.getAttributes()
      admin: @project.isAdmin window.user
      isCollection: isCollection
      size: aoi_size
      eezs: eezs
    
    @$el.html @template.render(context, templates)


  addCommas: (num_str) =>
    num_str += ''
    x = num_str.split('.')
    x1 = x[0]
    x2 = if x.length > 1 then '.' + x[1] else ''
    rgx = /(\d+)(\d{3})/
    while rgx.test(x1)
      x1 = x1.replace(rgx, '$1' + ',' + '$2')
    return x1 + x2

module.exports = OverviewTab