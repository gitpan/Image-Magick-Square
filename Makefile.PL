use ExtUtils::MakeMaker;
WriteMakefile(
    NAME              => 'Image-Magick-Square',
    VERSION_FROM      => 'lib/Image/Magick/Square.pm', 
    PREREQ_PM         => {
                Image::Magick => 0.1,
         },
    ($] >= 5.005 ?     
      (AUTHOR         => 'leo charre <leo@leocharre.com>') : ()),
);
