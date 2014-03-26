<?php

/* commits_list.twig */
class __TwigTemplate_59e83131598cd6a3e6ff3a74f408787c extends Twig_Template
{
    public function __construct(Twig_Environment $env)
    {
        parent::__construct($env);

        $this->parent = false;

        $this->blocks = array(
        );
    }

    protected function doDisplay(array $context, array $blocks = array())
    {
        // line 1
        if (isset($context["commits"])) { $_commits_ = $context["commits"]; } else { $_commits_ = null; }
        if ($_commits_) {
            // line 2
            if (isset($context["commits"])) { $_commits_ = $context["commits"]; } else { $_commits_ = null; }
            $context['_parent'] = (array) $context;
            $context['_seq'] = twig_ensure_traversable($_commits_);
            foreach ($context['_seq'] as $context["date"] => $context["commit"]) {
                // line 3
                echo "<table class=\"table table-striped table-bordered\">
    <thead>
        <tr>
            <th colspan=\"3\">";
                // line 6
                if (isset($context["date"])) { $_date_ = $context["date"]; } else { $_date_ = null; }
                echo twig_escape_filter($this->env, twig_date_format_filter($this->env, $_date_, "F j, Y"), "html", null, true);
                echo "</th>
        </tr>
    </thead>
    <tbody>
        ";
                // line 10
                if (isset($context["commit"])) { $_commit_ = $context["commit"]; } else { $_commit_ = null; }
                $context['_parent'] = (array) $context;
                $context['_seq'] = twig_ensure_traversable($_commit_);
                foreach ($context['_seq'] as $context["_key"] => $context["item"]) {
                    // line 11
                    echo "        <tr>
            <td width=\"5%\"><img src=\"http://gravatar.com/avatar/";
                    // line 12
                    if (isset($context["item"])) { $_item_ = $context["item"]; } else { $_item_ = null; }
                    echo twig_escape_filter($this->env, md5(twig_lower_filter($this->env, $this->getAttribute($this->getAttribute($_item_, "author"), "email"))), "html", null, true);
                    echo "?s=40\" /></td>
            <td width=\"95%\">
                <span class=\"pull-right\"><a class=\"btn btn-small\" href=\"";
                    // line 14
                    if (isset($context["repo"])) { $_repo_ = $context["repo"]; } else { $_repo_ = null; }
                    if (isset($context["item"])) { $_item_ = $context["item"]; } else { $_item_ = null; }
                    echo twig_escape_filter($this->env, $this->env->getExtension('routing')->getPath("commit", array("repo" => $_repo_, "commit" => $this->getAttribute($_item_, "hash"))), "html", null, true);
                    echo "\"><i class=\"icon-list-alt\"></i> View ";
                    if (isset($context["item"])) { $_item_ = $context["item"]; } else { $_item_ = null; }
                    echo twig_escape_filter($this->env, $this->getAttribute($_item_, "shortHash"), "html", null, true);
                    echo "</a></span>
                <h4>";
                    // line 15
                    if (isset($context["item"])) { $_item_ = $context["item"]; } else { $_item_ = null; }
                    echo twig_escape_filter($this->env, $this->getAttribute($_item_, "message"), "html", null, true);
                    echo "</h4>
                <span><a href=\"mailto:";
                    // line 16
                    if (isset($context["item"])) { $_item_ = $context["item"]; } else { $_item_ = null; }
                    echo twig_escape_filter($this->env, $this->getAttribute($this->getAttribute($_item_, "author"), "email"), "html", null, true);
                    echo "\">";
                    if (isset($context["item"])) { $_item_ = $context["item"]; } else { $_item_ = null; }
                    echo twig_escape_filter($this->env, $this->getAttribute($this->getAttribute($_item_, "author"), "name"), "html", null, true);
                    echo "</a> authored on ";
                    if (isset($context["item"])) { $_item_ = $context["item"]; } else { $_item_ = null; }
                    echo twig_escape_filter($this->env, twig_date_format_filter($this->env, $this->getAttribute($_item_, "date"), "d/m/Y \\a\\t H:i:s"), "html", null, true);
                    echo "</span>
            </td>
        </tr>
        ";
                }
                $_parent = $context['_parent'];
                unset($context['_seq'], $context['_iterated'], $context['_key'], $context['item'], $context['_parent'], $context['loop']);
                $context = array_merge($_parent, array_intersect_key($context, $_parent));
                // line 20
                echo "    </tbody>
</table>
";
            }
            $_parent = $context['_parent'];
            unset($context['_seq'], $context['_iterated'], $context['date'], $context['commit'], $context['_parent'], $context['loop']);
            $context = array_merge($_parent, array_intersect_key($context, $_parent));
        } else {
            // line 24
            echo "<p>No results found.</p>
";
        }
        // line 26
        echo "
";
        // line 27
        if (isset($context["page"])) { $_page_ = $context["page"]; } else { $_page_ = null; }
        if (($_page_ != "searchcommits")) {
            // line 28
            echo "<ul class=\"pager\">
    ";
            // line 29
            if (isset($context["pager"])) { $_pager_ = $context["pager"]; } else { $_pager_ = null; }
            if (($this->getAttribute($_pager_, "current") != 0)) {
                // line 30
                echo "    <li class=\"previous\">
        <a href=\"?page=";
                // line 31
                if (isset($context["pager"])) { $_pager_ = $context["pager"]; } else { $_pager_ = null; }
                echo twig_escape_filter($this->env, $this->getAttribute($_pager_, "previous"), "html", null, true);
                echo "\">&larr; Newer</a>
    </li>
    ";
            }
            // line 34
            echo "    ";
            if (isset($context["pager"])) { $_pager_ = $context["pager"]; } else { $_pager_ = null; }
            if (($this->getAttribute($_pager_, "current") != $this->getAttribute($_pager_, "last"))) {
                // line 35
                echo "    <li class=\"next\">
        <a href=\"?page=";
                // line 36
                if (isset($context["pager"])) { $_pager_ = $context["pager"]; } else { $_pager_ = null; }
                echo twig_escape_filter($this->env, $this->getAttribute($_pager_, "next"), "html", null, true);
                echo "\">Older &rarr;</a>
    </li>
    ";
            }
            // line 39
            echo "</ul>
";
        }
    }

    public function getTemplateName()
    {
        return "commits_list.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  134 => 39,  127 => 36,  124 => 35,  120 => 34,  113 => 31,  110 => 30,  107 => 29,  104 => 28,  101 => 27,  98 => 26,  94 => 24,  85 => 20,  68 => 16,  63 => 15,  54 => 14,  45 => 11,  32 => 6,  27 => 3,  22 => 2,  19 => 1,  48 => 12,  46 => 10,  43 => 9,  40 => 10,  37 => 7,  31 => 5,  26 => 3,);
    }
}
