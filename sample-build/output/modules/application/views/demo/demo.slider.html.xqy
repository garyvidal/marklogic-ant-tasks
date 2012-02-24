declare default element namespace "http://www.w3.org/1999/xhtml";
<div id="page-content-wrapper">
<link href="/resources/css/ui/ui.slider.css" rel="stylesheet" media="all" />
<script type="text/javascript" src="/resources/js/ui/ui.slider.js">//</script>
	<style type="text/css"><![CDATA[
	#red, #green, #blue {
		float: left;
		clear: left;
		width: 300px;
		margin: 15px;
	}
	#swatch {
		width: 120px;
		height: 100px;
		margin-top: 18px;
		margin-left: 350px;
		background-image: none;
	}
	#red .ui-slider-range { background: #ef2929; }
	#red .ui-slider-handle { border-color: #ef2929; }
	#green .ui-slider-range { background: #8ae234; }
	#green .ui-slider-handle { border-color: #8ae234; }
	#blue .ui-slider-range { background: #729fcf; }
	#blue .ui-slider-handle { border-color: #729fcf; }

		#eq span {
			height:120px; float:left; margin:15px
		}
    ]]>
	</style>
	<script type="text/javascript"><![CDATA[
	$(function() {
		$("#slider-range").slider({
			range: true,
			min: 0,
			max: 500,
			values: [75, 300],
			slide: function(event, ui) {
				$("#amount").val('$' + ui.values[0] + ' - $' + ui.values[1]);
			}
		});
		$("#amount").val('$' + $("#slider-range").slider("values", 0) + ' - $' + $("#slider-range").slider("values", 1));
	});]]>
	</script>

	<script type="text/javascript"><![CDATA[
	function hexFromRGB (r, g, b) {
		var hex = [
			r.toString(16),
			g.toString(16),
			b.toString(16)
		];
		$.each(hex, function (nr, val) {
			if (val.length == 1) {
				hex[nr] = '0' + val;
			}
		});
		return hex.join('').toUpperCase();
	}
	function refreshSwatch() {
		var red = $("#red").slider("value")
			,green = $("#green").slider("value")
			,blue = $("#blue").slider("value")
			,hex = hexFromRGB(red, green, blue);
		$("#swatch").css("background-color", "#" + hex);
	}
	$(function() {
		$("#red, #green, #blue").slider({
			orientation: 'horizontal',
			range: "min",
			max: 255,
			value: 127,
			slide: refreshSwatch,
			change: refreshSwatch
		});
		$("#red").slider("value", 255);
		$("#green").slider("value", 140);
		$("#blue").slider("value", 60);
	});]]>
	</script>
	<script type="text/javascript"><![CDATA[
	$(function() {
		// change defaults for range, animate and orientation
		$.extend($.ui.slider.defaults, {
			range: "min",
			animate: true,
			orientation: "vertical"
		});
		// setup master volume
		$("#master").slider({
			value: 60,
			orientation: "horizontal"
		});
		// setup Example
		$("#eq > span").each(function() {
			// read initial values from markup and remove that
			var value = parseInt($(this).text());
			$(this).empty();
			$(this).slider({
				value: value
			})
		});
	});
	]]>
	</script>
	<div class="inner-page-title">
		<h2>Example 1</h2>
		<span>Combine three sliders to create a simple RGB colorpicker.</span>
	</div>
	<p style="padding: 4px;" class="ui-state-default ui-corner-all ui-helper-clearfix">
		<span class="ui-icon float-left ui-icon-pencil"></span>
		Simple Colorpicker
	</p>
	<div id="red"></div>
	<div id="green"></div>
	<div id="blue"></div>
	
	<div id="swatch" class="ui-widget-content ui-corner-all"></div>

	<div class="clearfix"></div>
	<div class="inner-page-title">
		<h3>Example 2</h3>
	</div>
	<div class="content-box">
		<p style="padding: 4px;" class="ui-state-default ui-corner-all">
			<span class="ui-icon float-left ui-icon-signal"></span>
			Example
		</p>
		<div id="eq">
			<span>88</span>
			<span>77</span>
			<span>55</span>	
			<span>33</span>
			<span>40</span>
			<span>45</span>
			<span>70</span>
		</div>
		<div class="clearfix"></div>
	</div>
	<div class="clearfix"></div>
	<div class="inner-page-title">
		<h3>Example 3</h3>
	</div>
	<p>
		<label for="amount">Price range:</label>
		<input type="text" id="amount" style="border:0; color:#f6931f; font-weight:bold;" />
		
	</p>
	<div id="slider-range"></div>
	<div class="clearfix"></div>

	<i class="note">* Example note ( class="note" ).</i>
	<?template name="sidebar" ?>
</div>

