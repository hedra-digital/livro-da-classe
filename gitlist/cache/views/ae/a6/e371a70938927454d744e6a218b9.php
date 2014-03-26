<?php

/* tree.twig */
class __TwigTemplate_aea6e371a70938927454d744e6a218b9 extends Twig_Template
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
        $context["page"] = "files";
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
        if (isset($context["breadcrumbs"])) { $_breadcrumbs_ = $context["breadcrumbs"]; } else { $_breadcrumbs_ = null; }
        $this->env->loadTemplate("tree.twig", "1826636891")->display(array_merge($context, array("breadcrumbs" => $_breadcrumbs_)));
        // line 19
        echo "
    ";
        // line 20
        if (isset($context["files"])) { $_files_ = $context["files"]; } else { $_files_ = null; }
        if ((!twig_test_empty($_files_))) {
            // line 21
            echo "    <table class=\"tree\">
        <thead>
            <tr>
                <th width=\"80%\">name</th>
                <th width=\"10%\">mode</th>
                <th width=\"10%\">size</th>
            </tr>
        </thead>
        <tbody>
            ";
            // line 30
            if (isset($context["parent"])) { $_parent_ = $context["parent"]; } else { $_parent_ = null; }
            if ((!(null === $_parent_))) {
                // line 31
                echo "            <tr>
                <td><i class=\"icon-spaced\"></i>
                    ";
                // line 33
                if (isset($context["parent"])) { $_parent_ = $context["parent"]; } else { $_parent_ = null; }
                if ((!$_parent_)) {
                    // line 34
                    echo "                        <a href=\"";
                    if (isset($context["repo"])) { $_repo_ = $context["repo"]; } else { $_repo_ = null; }
                    if (isset($context["branch"])) { $_branch_ = $context["branch"]; } else { $_branch_ = null; }
                    echo twig_escape_filter($this->env, $this->env->getExtension('routing')->getPath("branch", array("repo" => $_repo_, "branch" => $_branch_)), "html", null, true);
                    echo "\">..</a>
                    ";
                } else {
                    // line 36
                    echo "                        <a href=\"";
                    if (isset($context["repo"])) { $_repo_ = $context["repo"]; } else { $_repo_ = null; }
                    if (isset($context["branch"])) { $_branch_ = $context["branch"]; } else { $_branch_ = null; }
                    if (isset($context["parent"])) { $_parent_ = $context["parent"]; } else { $_parent_ = null; }
                    echo twig_escape_filter($this->env, $this->env->getExtension('routing')->getPath("tree", array("repo" => $_repo_, "commitishPath" => (($_branch_ . "/") . $_parent_))), "html", null, true);
                    echo "\">..</a>
                    ";
                }
                // line 38
                echo "                </td>
                <td></td>
                <td></td>
            </tr>
            ";
            }
            // line 43
            echo "            ";
            if (isset($context["files"])) { $_files_ = $context["files"]; } else { $_files_ = null; }
            $context['_parent'] = (array) $context;
            $context['_seq'] = twig_ensure_traversable($_files_);
            foreach ($context['_seq'] as $context["_key"] => $context["file"]) {
                // line 44
                echo "            <tr>
                <td><i class=\"";
                // line 45
                if (isset($context["file"])) { $_file_ = $context["file"]; } else { $_file_ = null; }
                echo (((($this->getAttribute($_file_, "type") == "folder") || ($this->getAttribute($_file_, "type") == "symlink"))) ? ("icon-folder-open") : ("icon-file"));
                echo " icon-spaced\"></i> <a href=\"";
                // line 46
                if (isset($context["file"])) { $_file_ = $context["file"]; } else { $_file_ = null; }
                if ((($this->getAttribute($_file_, "type") == "folder") || ($this->getAttribute($_file_, "type") == "symlink"))) {
                    // line 47
                    if (isset($context["repo"])) { $_repo_ = $context["repo"]; } else { $_repo_ = null; }
                    if (isset($context["branch"])) { $_branch_ = $context["branch"]; } else { $_branch_ = null; }
                    if (isset($context["path"])) { $_path_ = $context["path"]; } else { $_path_ = null; }
                    if (isset($context["file"])) { $_file_ = $context["file"]; } else { $_file_ = null; }
                    echo twig_escape_filter($this->env, $this->env->getExtension('routing')->getPath("tree", array("repo" => $_repo_, "commitishPath" => ((($_branch_ . "/") . $_path_) . ((($this->getAttribute($_file_, "type") == "symlink")) ? ($this->getAttribute($_file_, "path")) : ($this->getAttribute($_file_, "name")))))), "html", null, true);
                } else {
                    // line 49
                    if (isset($context["repo"])) { $_repo_ = $context["repo"]; } else { $_repo_ = null; }
                    if (isset($context["branch"])) { $_branch_ = $context["branch"]; } else { $_branch_ = null; }
                    if (isset($context["path"])) { $_path_ = $context["path"]; } else { $_path_ = null; }
                    if (isset($context["file"])) { $_file_ = $context["file"]; } else { $_file_ = null; }
                    echo twig_escape_filter($this->env, $this->env->getExtension('routing')->getPath("blob", array("repo" => $_repo_, "commitishPath" => ((($_branch_ . "/") . $_path_) . ((($this->getAttribute($_file_, "type") == "symlink")) ? ($this->getAttribute($_file_, "path")) : ($this->getAttribute($_file_, "name")))))), "html", null, true);
                }
                // line 51
                echo "\">";
                if (isset($context["file"])) { $_file_ = $context["file"]; } else { $_file_ = null; }
                echo twig_escape_filter($this->env, $this->getAttribute($_file_, "name"), "html", null, true);
                echo "</a></td>
                <td>";
                // line 52
                if (isset($context["file"])) { $_file_ = $context["file"]; } else { $_file_ = null; }
                echo twig_escape_filter($this->env, $this->getAttribute($_file_, "mode"), "html", null, true);
                echo "</td>
                <td>";
                // line 53
                if (isset($context["file"])) { $_file_ = $context["file"]; } else { $_file_ = null; }
                if ($this->getAttribute($_file_, "size")) {
                    if (isset($context["file"])) { $_file_ = $context["file"]; } else { $_file_ = null; }
                    echo twig_escape_filter($this->env, twig_number_format_filter($this->env, ($this->getAttribute($_file_, "size") / 1024)), "html", null, true);
                    echo " kb";
                }
                echo "</td>
            </tr>
            ";
            }
            $_parent = $context['_parent'];
            unset($context['_seq'], $context['_iterated'], $context['_key'], $context['file'], $context['_parent'], $context['loop']);
            $context = array_merge($_parent, array_intersect_key($context, $_parent));
            // line 56
            echo "        </tbody>
    </table>
    ";
        } else {
            // line 59
            echo "        <p>This repository is empty.</p>
    ";
        }
        // line 61
        echo "    ";
        if (isset($context["readme"])) { $_readme_ = $context["readme"]; } else { $_readme_ = null; }
        if ((array_key_exists("readme", $context) && (!twig_test_empty($_readme_)))) {
            // line 62
            echo "        <div class=\"readme-view\">
            <div class=\"md-header\">
                <div class=\"meta\">";
            // line 64
            if (isset($context["readme"])) { $_readme_ = $context["readme"]; } else { $_readme_ = null; }
            echo twig_escape_filter($this->env, $this->getAttribute($_readme_, "filename"), "html", null, true);
            echo "</div>
            </div>
            <div id=\"md-content\">";
            // line 66
            if (isset($context["readme"])) { $_readme_ = $context["readme"]; } else { $_readme_ = null; }
            echo twig_escape_filter($this->env, $this->getAttribute($_readme_, "content"), "html", null, true);
            echo "</div>
        </div>
    ";
        }
        // line 69
        echo "
    <hr />
";
    }

    public function getTemplateName()
    {
        return "tree.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  180 => 69,  173 => 66,  167 => 64,  163 => 62,  159 => 61,  155 => 59,  150 => 56,  136 => 53,  131 => 52,  125 => 51,  118 => 49,  111 => 47,  108 => 46,  104 => 45,  101 => 44,  95 => 43,  88 => 38,  79 => 36,  71 => 34,  68 => 33,  64 => 31,  61 => 30,  50 => 21,  47 => 20,  44 => 19,  40 => 8,  37 => 7,  31 => 5,  26 => 3,);
    }
}


/* tree.twig */
class __TwigTemplate_aea6e371a70938927454d744e6a218b9_1826636891 extends Twig_Template
{
    public function __construct(Twig_Environment $env)
    {
        parent::__construct($env);

        $this->parent = $this->env->loadTemplate("breadcrumb.twig");

        $this->blocks = array(
            'extra' => array($this, 'block_extra'),
        );
    }

    protected function doGetParent(array $context)
    {
        return "breadcrumb.twig";
    }

    protected function doDisplay(array $context, array $blocks = array())
    {
        $this->parent->display($context, array_merge($this->blocks, $blocks));
    }

    // line 9
    public function block_extra($context, array $blocks = array())
    {
        // line 10
        echo "            <div class=\"pull-right\">
                <div class=\"btn-group download-buttons\">
                    <a href=\"";
        // line 12
        if (isset($context["repo"])) { $_repo_ = $context["repo"]; } else { $_repo_ = null; }
        if (isset($context["branch"])) { $_branch_ = $context["branch"]; } else { $_branch_ = null; }
        echo twig_escape_filter($this->env, $this->env->getExtension('routing')->getPath("archive", array("repo" => $_repo_, "branch" => $_branch_, "format" => "zip")), "html", null, true);
        echo "\" class=\"btn btn-mini\" title=\"Download '";
        if (isset($context["branch"])) { $_branch_ = $context["branch"]; } else { $_branch_ = null; }
        echo twig_escape_filter($this->env, $_branch_, "html", null, true);
        echo "' as a ZIP archive\">ZIP</a>
                    <a href=\"";
        // line 13
        if (isset($context["repo"])) { $_repo_ = $context["repo"]; } else { $_repo_ = null; }
        if (isset($context["branch"])) { $_branch_ = $context["branch"]; } else { $_branch_ = null; }
        echo twig_escape_filter($this->env, $this->env->getExtension('routing')->getPath("archive", array("repo" => $_repo_, "branch" => $_branch_, "format" => "tar")), "html", null, true);
        echo "\" class=\"btn btn-mini\" title=\"Download '";
        if (isset($context["branch"])) { $_branch_ = $context["branch"]; } else { $_branch_ = null; }
        echo twig_escape_filter($this->env, $_branch_, "html", null, true);
        echo "' as a TAR archive\">TAR</a>
                </div>
                <a href=\"";
        // line 15
        if (isset($context["repo"])) { $_repo_ = $context["repo"]; } else { $_repo_ = null; }
        if (isset($context["branch"])) { $_branch_ = $context["branch"]; } else { $_branch_ = null; }
        echo twig_escape_filter($this->env, $this->env->getExtension('routing')->getPath("rss", array("repo" => $_repo_, "branch" => $_branch_)), "html", null, true);
        echo "\" class=\"rss-icon\"><i class=\"rss\"></i></a>
            </div>
        ";
    }

    public function getTemplateName()
    {
        return "tree.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  253 => 15,  243 => 13,  234 => 12,  230 => 10,  227 => 9,  180 => 69,  173 => 66,  167 => 64,  163 => 62,  159 => 61,  155 => 59,  150 => 56,  136 => 53,  131 => 52,  125 => 51,  118 => 49,  111 => 47,  108 => 46,  104 => 45,  101 => 44,  95 => 43,  88 => 38,  79 => 36,  71 => 34,  68 => 33,  64 => 31,  61 => 30,  50 => 21,  47 => 20,  44 => 19,  40 => 8,  37 => 7,  31 => 5,  26 => 3,);
    }
}
