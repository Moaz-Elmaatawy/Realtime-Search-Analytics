import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  connect() {
    this.debouncedSearch = this.debounce(this.sendSearchQuery, 300);
  }

  search() {
    const query = this.inputTarget.value;
    this.debouncedSearch(query);
  }

  sendSearchQuery(query) {
    fetch('/searches', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': this.getCSRFToken(),
      },
      body: JSON.stringify({ query: query })
    })
      .then(response => response.json())
      .then(data => this.updateArticlesList(data));
  }

  updateArticlesList(articles) {
    const articlesDiv = document.getElementById('articles');
    
    articlesDiv.innerHTML = '';

    articles.forEach(article => {
      const articleDiv = document.createElement('div');
      articleDiv.className = 'article';

      const title = document.createElement('h2');
      title.innerText = article.title;

      const content = document.createElement('p');
      content.innerText = article.content;

      articleDiv.appendChild(title);
      articleDiv.appendChild(content);
      articlesDiv.appendChild(articleDiv);
    });
  }


  getCSRFToken() {
    return document.querySelector("meta[name='csrf-token']").getAttribute('content');
  }

  debounce(func, wait) {
    let timeout;
    return function (...args) {
      const later = () => {
        timeout = null;
        func.apply(this, args);
      };
      clearTimeout(timeout);
      timeout = setTimeout(later, wait);
    };
  }
}
