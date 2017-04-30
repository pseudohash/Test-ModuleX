use Perl::Critic;
use File::Find;

# Note: For some reason have to have the criticicing done outside of the wanted function
# otherwise it throws an error.
my @files;

find(\&wanted, './lib');

sub wanted {
  my $file = $File::Find::name; #/some/path/foo.ext
  my $fileName = $_; # foo.ext
  
  if($fileName =~ m/.pm$/) {
    push @files, $file;
  }
}

foreach my $file (@files) {
  print "########## Critiquing: $file ##########\n";
  my $critic = Perl::Critic->new();
  my @violations = $critic->critique($file);
  print @violations;
  
  $count = @violations;
  print 'FINAL -> '.$count.' violations found'."\n";
}
