package Image::Magick::Square;
use Image::Magick;
use Carp;

use strict;
use warnings;
our $VERSION = sprintf "%d.%03d", q$Revision: 1.1.1.1 $ =~ /(\d+)/g;

# Image Magick Square
# square an image, chop as needed
sub create {
	my $img = shift; # takes image magick object read into
	if (not $img) {
		warn "no image defined..".__PACKAGE__;
		return undef;
	} 

	my ($x,$y) = $img->Get('width','height');

	# if width and height are same, then this image is already square.
	if ($x == $y) { return $img, $x; }  

	# what is the smallest side of the image?
	# we take that to be the height and width
	# of the largest square we can fit in the image.
	# save that value as $cropby
	
	my $cropby= undef; 
	if ($x > $y) { 
		$cropby = $y;
		$x =int(($x - $cropby )/2);
		$y = 0;		
	} 

	else { 
		$cropby = $x ;
		$y =int(($y - $cropby )/2);
		$x = 0;	
	}
	
	$img->Crop( width=>$cropby, height=>$cropby, x=>$x, y => $y);

	return $img, $cropby;

}

1;

__END__

=head1 NAME

Image::Magick::Square - Takes image and crops to a square

=head1 SYNOPSIS

	use Image::Magick::Square;
	
	# Load your source image
	my $src = new Image::Magick;
	$src->Read('source.jpg');

	# crop to square image
	my $square_thumb = Image::Magick::Square::create($thumb);

	# Save it 
	$square_thumb->Write('square.jpg');

=cut


=head1 EXAMPLE

To make a square thumbnail:

	use Image::Magick::Square;
	
	# Load your source image
	my $src = new Image::Magick;
	$src->Read('source.jpg');

	# make into a thumbnail
	my ($thumb,$x,$y) = Image::Magick::Thumbnail::create($src,50);

	# crop to biggest square that will fit inside image.
	my ($square_thumb,$side) = Image::Magick::Square::create($thumb);

	# Save it 
	$square_thumb->Write('square_thumb.jpg');

=cut	

=head1 DESCRIPTION

The subroutine C<create> takes as argument an ImageMagick image object.

It returns an ImageMagick image object (the thumbnail), as well as the
number of pixels of the I<side> of the image.

It does not take dimension arguments, because if your image is cropped
according to the dimensions it already posseses.

This module is useful if you want to make square thumbnails. You should
first make the thumbnail, and then call C<create>, so as to use less of
the computer's resources. 

You can run this conversion on any image magick object. 

=cut

=head1 PREREQUISITES

C<Image::Magick>

=cut

=head2 NOTES

Yes, L<Image::Magick::Thumbnail::Fixed> will make a fixed size thumbnail.
It's great, I love it. Except for one thing, it does not take an existing
Image::Magick object to work on. It does too much.  It doesn't return an
image object either.

Image::Magick::Square is more a specialized crop then a "thumbnail routine".
This way, you can add more effects, like a shadow, a border, annotate- etc, 
I<before> you save or display the image.

=cut

=head2 EXPORT

None by default.

=head1 SEE ALSO

L<perl>, L<Image::Magick>, L<Image::GD::Thumbnail>, 
L<Image::Magick::Thumbnail>, L<Image::Magick::Thumbnail::Fixed>.

=head1 AUTHOR

Leo Charre, E<lt>leo@leocharre.comE<gt>

=head1 COPYRIGHT

Copyright (C) Leo Charre 2006 all rights reserved.
Available under the same terms as Perl itself.

=cut

