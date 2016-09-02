# Segment.js
A jQuery plugin that transform any `select` element into a beautiful ios style segment control.

Demo: http://jsfiddle.net/sa3Lap58/

Usage:

```html
<!-- Include the css -->

<link rel="stylesheet" type="text/css" href="segment.css" />

<!-- Add some select elemets -->

<select class="segment-select">
	<option value="1">None</option>
	<option value="2">First</option>
	<option value="3">Second</option>
</select>

<select class="segment-select">
	<option value="1">Yes</option>
	<option value="0">No</option>
</select>

<!-- Load jQuery and Segment.js -->

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script type="text/javascript" src="segment.js"></script>

<!--  Transform all select elements with the class of `segment-select` -->

<script type="text/javascript">
	jQuery(function ($){
	     $(".segment-select").Segment();
	});
</script>
```
