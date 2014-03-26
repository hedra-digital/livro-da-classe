<?php

/* commit.twig */
class __TwigTemplate_5afe87a6571274456a73e22638c09c6e extends Twig_Template
{
    public function __construct(Twig_Environment $env)
    {
        parent::__construct($env);

        $this->parent = $this->env->loadTemplate("layout_page.twig");

        $this->blocks = array(
            'title' => array($this, 'block_title'),
            'content' => array($this, 'block_content'),
        );
    }

    protected function doGetParent(array $context)
    {
        return "layout_page.twig";
    }

    protected function doDisplay(array $context, array $blocks = array())
    {
        // line 3
        $context["page"] = "commits";
        $this->parent->display($context, array_merge($this->blocks, $blocks));
    }

    // line 5
    public function block_title($context, array $blocks = array())
    {
        echo "GitList";
    }

    // line 7
    public function block_content($context, array $blocks = array())
    {
        // line 8
        echo "    ";
        if (isset($context["commit"])) { $_commit_ = $context["commit"]; } else { $_commit_ = null; }
        $this->env->loadTemplate("breadcrumb.twig")->display(array_merge($context, array("breadcrumbs" => array(0 => array("dir" => ("Commit " . $this->getAttribute($_commit_, "hash")), "path" => "")))));
        // line 9
        echo "
    <div class=\"commit-view\">
        <div class=\"commit-header\">
            <span class=\"pull-right\"><a class=\"btn btn-small\" href=\"";
        // line 12
        if (isset($context["repo"])) { $_repo_ = $context["repo"]; } else { $_repo_ = null; }
        if (isset($context["commit"])) { $_commit_ = $context["commit"]; } else { $_commit_ = null; }
        echo twig_escape_filter($this->env, $this->env->getExtension('routing')->getPath("branch", array("repo" => $_repo_, "branch" => $this->getAttribute($_commit_, "hash"))), "html", null, true);
        echo "\" title=\"Browse code at this point in history\"><i class=\"icon-list-alt\"></i> Browse code</a></span>
            <h4>";
        // line 13
        if (isset($context["commit"])) { $_commit_ = $context["commit"]; } else { $_commit_ = null; }
        echo twig_escape_filter($this->env, $this->getAttribute($_commit_, "message"), "html", null, true);
        echo "</h4>
        </div>
        <div class=\"commit-body\">
            ";
        // line 16
        if (isset($context["commit"])) { $_commit_ = $context["commit"]; } else { $_commit_ = null; }
        if ((!twig_test_empty($this->getAttribute($_commit_, "body")))) {
            // line 17
            echo "            <p>";
            if (isset($context["commit"])) { $_commit_ = $context["commit"]; } else { $_commit_ = null; }
            echo nl2br(twig_escape_filter($this->env, $this->getAttribute($_commit_, "body"), "html", null, true));
            echo "</p>
            ";
        }
        // line 19
        echo "            <img src=\"https://gravatar.com/avatar/";
        if (isset($context["commit"])) { $_commit_ = $context["commit"]; } else { $_commit_ = null; }
        echo twig_escape_filter($this->env, md5(twig_lower_filter($this->env, $this->getAttribute($this->getAttribute($_commit_, "author"), "email"))), "html", null, true);
        echo "?s=32\" class=\"pull-left space-right\" />
            <span><a href=\"mailto:";
        // line 20
        if (isset($context["commit"])) { $_commit_ = $context["commit"]; } else { $_commit_ = null; }
        echo twig_escape_filter($this->env, $this->getAttribute($this->getAttribute($_commit_, "author"), "email"), "html", null, true);
        echo "\">";
        if (isset($context["commit"])) { $_commit_ = $context["commit"]; } else { $_commit_ = null; }
        echo twig_escape_filter($this->env, $this->getAttribute($this->getAttribute($_commit_, "author"), "name"), "html", null, true);
        echo "</a> authored on ";
        if (isset($context["commit"])) { $_commit_ = $context["commit"]; } else { $_commit_ = null; }
        echo twig_escape_filter($this->env, twig_date_format_filter($this->env, $this->getAttribute($_commit_, "date"), "d/m/Y \\a\\t H:i:s"), "html", null, true);
        echo "<br />Showing ";
        if (isset($context["commit"])) { $_commit_ = $context["commit"]; } else { $_commit_ = null; }
        echo twig_escape_filter($this->env, $this->getAttribute($_commit_, "changedFiles"), "html", null, true);
        echo " changed files</span>
        </div>
    </div>

    <ul class=\"commit-list\">
        ";
        // line 25
        if (isset($context["commit"])) { $_commit_ = $context["commit"]; } else { $_commit_ = null; }
        $context['_parent'] = (array) $context;
        $context['_seq'] = twig_ensure_traversable($this->getAttribute($_commit_, "diffs"));
        $context['loop'] = array(
          'parent' => $context['_parent'],
          'index0' => 0,
          'index'  => 1,
          'first'  => true,
        );
        if (is_array($context['_seq']) || (is_object($context['_seq']) && $context['_seq'] instanceof Countable)) {
            $length = count($context['_seq']);
            $context['loop']['revindex0'] = $length - 1;
            $context['loop']['revindex'] = $length;
            $context['loop']['length'] = $length;
            $context['loop']['last'] = 1 === $length;
        }
        foreach ($context['_seq'] as $context["_key"] => $context["diff"]) {
            // line 26
            echo "            <li><i class=\"icon-file\"></i> <a href=\"#";
            if (isset($context["loop"])) { $_loop_ = $context["loop"]; } else { $_loop_ = null; }
            echo twig_escape_filter($this->env, $this->getAttribute($_loop_, "index"), "html", null, true);
            echo "\">";
            if (isset($context["diff"])) { $_diff_ = $context["diff"]; } else { $_diff_ = null; }
            echo twig_escape_filter($this->env, $this->getAttribute($_diff_, "file"), "html", null, true);
            echo "</a> <span class=\"meta pull-right\">";
            if (isset($context["diff"])) { $_diff_ = $context["diff"]; } else { $_diff_ = null; }
            echo twig_escape_filter($this->env, $this->getAttribute($_diff_, "index"), "html", null, true);
            echo "</span></li>
        ";
            ++$context['loop']['index0'];
            ++$context['loop']['index'];
            $context['loop']['first'] = false;
            if (isset($context['loop']['length'])) {
                --$context['loop']['revindex0'];
                --$context['loop']['revindex'];
                $context['loop']['last'] = 0 === $context['loop']['revindex0'];
            }
        }
        $_parent = $context['_parent'];
        unset($context['_seq'], $context['_iterated'], $context['_key'], $context['diff'], $context['_parent'], $context['loop']);
        $context = array_merge($_parent, array_intersect_key($context, $_parent));
        // line 28
        echo "    </ul>

    ";
        // line 30
        if (isset($context["commit"])) { $_commit_ = $context["commit"]; } else { $_commit_ = null; }
        $context['_parent'] = (array) $context;
        $context['_seq'] = twig_ensure_traversable($this->getAttribute($_commit_, "diffs"));
        $context['loop'] = array(
          'parent' => $context['_parent'],
          'index0' => 0,
          'index'  => 1,
          'first'  => true,
        );
        if (is_array($context['_seq']) || (is_object($context['_seq']) && $context['_seq'] instanceof Countable)) {
            $length = count($context['_seq']);
            $context['loop']['revindex0'] = $length - 1;
            $context['loop']['revindex'] = $length;
            $context['loop']['length'] = $length;
            $context['loop']['last'] = 1 === $length;
        }
        foreach ($context['_seq'] as $context["_key"] => $context["diff"]) {
            // line 31
            echo "    <div class=\"source-view\">
        <div class=\"source-header\">
            <div class=\"meta\"><a name=\"";
            // line 33
            if (isset($context["loop"])) { $_loop_ = $context["loop"]; } else { $_loop_ = null; }
            echo twig_escape_filter($this->env, $this->getAttribute($_loop_, "index"), "html", null, true);
            echo "\">";
            if (isset($context["diff"])) { $_diff_ = $context["diff"]; } else { $_diff_ = null; }
            echo twig_escape_filter($this->env, $this->getAttribute($_diff_, "file"), "html", null, true);
            echo "</div>

            <div class=\"btn-group pull-right\">
                <a href=\"";
            // line 36
            if (isset($context["repo"])) { $_repo_ = $context["repo"]; } else { $_repo_ = null; }
            if (isset($context["commit"])) { $_commit_ = $context["commit"]; } else { $_commit_ = null; }
            if (isset($context["diff"])) { $_diff_ = $context["diff"]; } else { $_diff_ = null; }
            echo twig_escape_filter($this->env, $this->env->getExtension('routing')->getPath("commits", array("repo" => $_repo_, "commitishPath" => (($this->getAttribute($_commit_, "hash") . "/") . $this->getAttribute($_diff_, "file")))), "html", null, true);
            echo "\" class=\"btn btn-small\"><i class=\"icon-list-alt\"></i> History</a>
                <a href=\"";
            // line 37
            if (isset($context["repo"])) { $_repo_ = $context["repo"]; } else { $_repo_ = null; }
            if (isset($context["commit"])) { $_commit_ = $context["commit"]; } else { $_commit_ = null; }
            if (isset($context["diff"])) { $_diff_ = $context["diff"]; } else { $_diff_ = null; }
            echo twig_escape_filter($this->env, $this->env->getExtension('routing')->getPath("blob", array("repo" => $_repo_, "commitishPath" => (($this->getAttribute($_commit_, "hash") . "/") . $this->getAttribute($_diff_, "file")))), "html", null, true);
            echo "\" class=\"btn btn-small\"><i class=\"icon-file\"></i> View file @ ";
            if (isset($context["commit"])) { $_commit_ = $context["commit"]; } else { $_commit_ = null; }
            echo twig_escape_filter($this->env, $this->getAttribute($_commit_, "shortHash"), "html", null, true);
            echo "</a>
            </div>
        </div>

        <div class=\"source-diff\">
        <table>
        ";
            // line 43
            if (isset($context["diff"])) { $_diff_ = $context["diff"]; } else { $_diff_ = null; }
            $context['_parent'] = (array) $context;
            $context['_seq'] = twig_ensure_traversable($this->getAttribute($_diff_, "getLines"));
            $context['loop'] = array(
              'parent' => $context['_parent'],
              'index0' => 0,
              'index'  => 1,
              'first'  => true,
            );
            if (is_array($context['_seq']) || (is_object($context['_seq']) && $context['_seq'] instanceof Countable)) {
                $length = count($context['_seq']);
                $context['loop']['revindex0'] = $length - 1;
                $context['loop']['revindex'] = $length;
                $context['loop']['length'] = $length;
                $context['loop']['last'] = 1 === $length;
            }
            foreach ($context['_seq'] as $context["_key"] => $context["line"]) {
                // line 44
                echo "            <tr>
                <td class=\"lineNo\">
                    ";
                // line 46
                if (isset($context["line"])) { $_line_ = $context["line"]; } else { $_line_ = null; }
                if (($this->getAttribute($_line_, "getType") != "chunk")) {
                    // line 47
                    echo "                        <a name=\"L";
                    if (isset($context["loop"])) { $_loop_ = $context["loop"]; } else { $_loop_ = null; }
                    echo twig_escape_filter($this->env, $this->getAttribute($_loop_, "index"), "html", null, true);
                    echo "R";
                    if (isset($context["line"])) { $_line_ = $context["line"]; } else { $_line_ = null; }
                    echo twig_escape_filter($this->env, $this->getAttribute($_line_, "getNumOld"), "html", null, true);
                    echo "\"></a>
                        <a href=\"#L";
                    // line 48
                    if (isset($context["loop"])) { $_loop_ = $context["loop"]; } else { $_loop_ = null; }
                    echo twig_escape_filter($this->env, $this->getAttribute($_loop_, "index"), "html", null, true);
                    echo "L";
                    if (isset($context["line"])) { $_line_ = $context["line"]; } else { $_line_ = null; }
                    echo twig_escape_filter($this->env, $this->getAttribute($_line_, "getNumOld"), "html", null, true);
                    echo "\">
                    ";
                }
                // line 50
                echo "                    ";
                if (isset($context["line"])) { $_line_ = $context["line"]; } else { $_line_ = null; }
                echo twig_escape_filter($this->env, $this->getAttribute($_line_, "getNumOld"), "html", null, true);
                echo "
                    ";
                // line 51
                if (isset($context["line"])) { $_line_ = $context["line"]; } else { $_line_ = null; }
                if (($this->getAttribute($_line_, "getType") != "chunk")) {
                    // line 52
                    echo "                        </a>
                    ";
                }
                // line 54
                echo "                </td>
                <td class=\"lineNo\">
                    ";
                // line 56
                if (isset($context["line"])) { $_line_ = $context["line"]; } else { $_line_ = null; }
                if (($this->getAttribute($_line_, "getType") != "chunk")) {
                    // line 57
                    echo "                        <a name=\"L";
                    if (isset($context["loop"])) { $_loop_ = $context["loop"]; } else { $_loop_ = null; }
                    echo twig_escape_filter($this->env, $this->getAttribute($_loop_, "index"), "html", null, true);
                    echo "L";
                    if (isset($context["line"])) { $_line_ = $context["line"]; } else { $_line_ = null; }
                    echo twig_escape_filter($this->env, $this->getAttribute($_line_, "getNumNew"), "html", null, true);
                    echo "\"></a>
                        <a href=\"#L";
                    // line 58
                    if (isset($context["loop"])) { $_loop_ = $context["loop"]; } else { $_loop_ = null; }
                    echo twig_escape_filter($this->env, $this->getAttribute($_loop_, "index"), "html", null, true);
                    echo "L";
                    if (isset($context["line"])) { $_line_ = $context["line"]; } else { $_line_ = null; }
                    echo twig_escape_filter($this->env, $this->getAttribute($_line_, "getNumNew"), "html", null, true);
                    echo "\">
                    ";
                }
                // line 60
                echo "                    ";
                if (isset($context["line"])) { $_line_ = $context["line"]; } else { $_line_ = null; }
                echo twig_escape_filter($this->env, $this->getAttribute($_line_, "getNumNew"), "html", null, true);
                echo "
                    ";
                // line 61
                if (isset($context["line"])) { $_line_ = $context["line"]; } else { $_line_ = null; }
                if (($this->getAttribute($_line_, "getType") != "chunk")) {
                    // line 62
                    echo "                        </a>
                    ";
                }
                // line 64
                echo "                </td>
                <td style=\"width: 100%\">
                    <pre";
                // line 66
                if (isset($context["line"])) { $_line_ = $context["line"]; } else { $_line_ = null; }
                if ($this->getAttribute($_line_, "getType")) {
                    echo " class=\"";
                    if (isset($context["line"])) { $_line_ = $context["line"]; } else { $_line_ = null; }
                    echo twig_escape_filter($this->env, $this->getAttribute($_line_, "getType"), "html", null, true);
                    echo "\"";
                }
                echo ">";
                if (isset($context["line"])) { $_line_ = $context["line"]; } else { $_line_ = null; }
                echo twig_escape_filter($this->env, $this->getAttribute($_line_, "getLine"), "html", null, true);
                echo "</pre>
                </td>
            </tr>
        ";
                ++$context['loop']['index0'];
                ++$context['loop']['index'];
                $context['loop']['first'] = false;
                if (isset($context['loop']['length'])) {
                    --$context['loop']['revindex0'];
                    --$context['loop']['revindex'];
                    $context['loop']['last'] = 0 === $context['loop']['revindex0'];
                }
            }
            $_parent = $context['_parent'];
            unset($context['_seq'], $context['_iterated'], $context['_key'], $context['line'], $context['_parent'], $context['loop']);
            $context = array_merge($_parent, array_intersect_key($context, $_parent));
            // line 70
            echo "        </table>
        </div>
    </div>
    ";
            ++$context['loop']['index0'];
            ++$context['loop']['index'];
            $context['loop']['first'] = false;
            if (isset($context['loop']['length'])) {
                --$context['loop']['revindex0'];
                --$context['loop']['revindex'];
                $context['loop']['last'] = 0 === $context['loop']['revindex0'];
            }
        }
        $_parent = $context['_parent'];
        unset($context['_seq'], $context['_iterated'], $context['_key'], $context['diff'], $context['_parent'], $context['loop']);
        $context = array_merge($_parent, array_intersect_key($context, $_parent));
        // line 74
        echo "
    <hr />
";
    }

    public function getTemplateName()
    {
        return "commit.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  338 => 74,  321 => 70,  294 => 66,  290 => 64,  286 => 62,  283 => 61,  277 => 60,  268 => 58,  259 => 57,  256 => 56,  252 => 54,  248 => 52,  245 => 51,  239 => 50,  230 => 48,  221 => 47,  218 => 46,  214 => 44,  196 => 43,  181 => 37,  174 => 36,  164 => 33,  160 => 31,  142 => 30,  138 => 28,  114 => 26,  96 => 25,  78 => 20,  72 => 19,  65 => 17,  62 => 16,  55 => 13,  49 => 12,  44 => 9,  40 => 8,  37 => 7,  31 => 5,  26 => 3,);
    }
}
