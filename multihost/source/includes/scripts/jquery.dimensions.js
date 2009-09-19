/* 
 * Copyright (c) 2007 Paul Bakaus (paul.bakaus@googlemail.com) and Brandon Aaron (brandon.aaron@gmail.com || http://brandonaaron.net)
 * Dual licensed under the MIT (http://www.opensource.org/licenses/mit-license.php)
 * and GPL (http://www.opensource.org/licenses/gpl-license.php) licenses.
 *
 * $LastChangedDate$
 * $Rev$
 *
 * Version: @VERSION
 *
 * Requires: jQuery 1.2+
 */
(function($){$.dimensions={version:'@VERSION'};$.each(['Height','Width'],function(i,d){$.fn['inner'+d]=function(){if(!this[0])return;var a=d=='Height'?'Top':'Left',borr=d=='Height'?'Bottom':'Right';return this.is(':visible')?this[0]['client'+d]:num(this,d.toLowerCase())+num(this,'padding'+a)+num(this,'padding'+borr)};$.fn['outer'+d]=function(a){if(!this[0])return;var b=d=='Height'?'Top':'Left',borr=d=='Height'?'Bottom':'Right';a=$.extend({margin:false},a||{});var c=this.is(':visible')?this[0]['offset'+d]:num(this,d.toLowerCase())+num(this,'border'+b+'Width')+num(this,'border'+borr+'Width')+num(this,'padding'+b)+num(this,'padding'+borr);return c+(a.margin?(num(this,'margin'+b)+num(this,'margin'+borr)):0)}});$.each(['Left','Top'],function(i,b){$.fn['scroll'+b]=function(a){if(!this[0])return;return a!=undefined?this.each(function(){this==window||this==document?window.scrollTo(b=='Left'?a:$(window)['scrollLeft'](),b=='Top'?a:$(window)['scrollTop']()):this['scroll'+b]=a}):this[0]==window||this[0]==document?self[(b=='Left'?'pageXOffset':'pageYOffset')]||$.boxModel&&document.documentElement['scroll'+b]||document.body['scroll'+b]:this[0]['scroll'+b]}});$.fn.extend({position:function(){var a=0,top=0,elem=this[0],offset,parentOffset,offsetParent,results;if(elem){offsetParent=this.offsetParent();offset=this.offset();parentOffset=offsetParent.offset();offset.top-=num(elem,'marginTop');offset.left-=num(elem,'marginLeft');parentOffset.top+=num(offsetParent,'borderTopWidth');parentOffset.left+=num(offsetParent,'borderLeftWidth');results={top:offset.top-parentOffset.top,left:offset.left-parentOffset.left}}return results},offsetParent:function(){var a=this[0].offsetParent;while(a&&(!/^body|html$/i.test(a.tagName)&&$.css(a,'position')=='static'))a=a.offsetParent;return $(a)}});function num(a,b){return parseInt($.curCSS(a.jquery?a[0]:a,b,true))||0}})(jQuery);