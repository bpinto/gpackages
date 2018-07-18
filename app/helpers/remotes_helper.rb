module RemotesHelper
  def generate_link(type, id)
    case type
    when 'bitbucket'
      "https://bitbucket.org/#{id}"
    when 'cpan', 'cpan-module', 'cpe', 'gentoo'
      #TODO: What should be displayed?
    when 'ctan'
      "https://ctan.org/pkg/#{id}"
    when 'freecode', 'freshmeat'
      "http://freshmeat.sourceforge.net/projects/#{id}"
    when 'github'
      "https://www.github.com/#{id}"
    when 'google-code'
      # Site no longer exists
    when 'launchpad'
      "https://launchpad.net/#{id}"
    when 'pear'
      "https://pear.php.net/package/#{id}"
    when 'pypi'
      "https://pypi.org/project/#{id}"
    when 'rubygems'
      "https://rubygems.org/gems/#{id}"
    when 'sourceforge'
      "https://sourceforge.net/projects/#{id}"
    when 'sourceforge-jp'
      "http://#{id}.osdn.jp"
    end
  end
end
