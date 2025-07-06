# Wiki Documentation

## Converting Documentation

To convert the `index.md` file to other formats:

### Convert to HTML

```bash
pandoc index.md -o index.html
```

### Convert to PDF

```bash
pandoc index.md -o index.pdf
```

### Convert to PDF with custom styling

```bash
pandoc index.md -o index.pdf --pdf-engine=xelatex
```

## Requirements

- Pandoc (for conversion)
- For PDF: LaTeX distribution (like TeX Live or MiKTeX)

