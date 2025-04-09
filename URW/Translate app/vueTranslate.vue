  const { createApp, ref, reactive } = Vue;

  function getCookie(name) {
    const value = `; ${document.cookie}`;
    const parts = value.split(`; ${name}=`);
    if (parts.length === 2) return parts.pop().split(';').shift();
  }

  createApp({
    data() {
      return {
        cookieValue: '',
        test: 'vueTranslate 69',
        trads: ref([]),
        refs: ref([]),
        type: ref('branded'),
        selectedCountry: ref(''),
        selectedCenter: ref(''),
        selectedEmail: ref(''),
        selectedCountryType: ref('All'),
        selectedBlock: ref(''),
        selectedBlockHTML: ref(''),
        currentBlock: ref({}),
        countryLoading: ref(false),
        centerLoading: ref(false),
        blockLoading: ref(false),
        oneBlockEditing: ref(false),
        oneBlockLoading: ref(false),
        formData: reactive({}),
        countries: ref([]),
        emails: ref([]),
        centers: ref([]),
        countryType: ref('M'),
        blocks: ref([]),
        dataBlock: ref({}),
        dataBlockKeys: ref({}),
        dataBlockDEKeys: ref({}),
        blockLabel: ref(''),
        de: ref(''),
        blockHTML: ref(''),
        saveOkMessage: ref(''),
        saveErrorMessage: ref(''),
        emailPreview: ref(''),
        showPreview: ref(false),
        showValidate: ref(false),
        validationChecked: ref(false),
        activeTab: ref('live'),
        activeClass:'py-2 px-4 text-blue-700 font-semibold border-b-2 border-blue-700 bg-gray-100 rounded-t-lg focus:outline-none focus:ring-2 focus:ring-blue-300 focus:ring-opacity-50 mb-4',
        inactiveClass:'py-2 px-4 text-gray-600 hover:text-blue-700 hover:bg-gray-200 font-medium rounded-t-lg focus:outline-none focus:ring-2 focus:ring-blue-300 focus:ring-opacity-50 mb-4',
        draftSnippetHTML: ref('')
      }
    },
    mounted() {
      this.cookieValue = getCookie('translateSession');
      this.getReference(this.cookieValue);
    },
    methods: {
      doNothing() {
          console.log('click deactivated');
      },
      resetBlocks() {
        this.blocks = [];
      },
      getCountriesFrom(data) {
        var countries = [];
        for(let i=0; i<data.length; i++) {
          if (!countries.includes(data[i].country)){
            countries.push(data[i].country);
          }}
        return countries;
      },
      getCountriesFromEmail(email){
        var countries = [];
        let result = Object.entries(obj).filter(([key, val]) => key == 'email_name' && val == email).map(([key, val]) => val);
        for(var i=0; i<result.length; i++) {
          if (!countries.includes(result[i].country)) {
            countries.push(result[i].country);
          }
        }
        return countries;
      },
      deduplicate(arr) {
        return arr.reduce((acc, obj) => {
          if (!acc.find(item => item.email_code === obj.email_code)) {
            acc.push(obj);
          }
          return acc;
        }, []);
      },
      getEmailsFrom(data) {
        //console.log('getEmailsFrom > data before : ', data);
        var dataAfter = this.deduplicate(data);
        //console.log('getEmailsFrom > data after : ', dataAfter);
        var emails = [];
        for(var i=0; i<dataAfter.length; i++) {
            emails.push({"email_code": dataAfter[i].email_code, "email_name": dataAfter[i].email_name});
        }
        return emails;
      },
      getReference(session) {
        console.log('getReference > session : ', session);
          try {
            axios.post(
              'https://cloud.email.westfield.com/translate_backend',
              {
                action: 'getReference',
                session: session
              },
              {
                headers: {
                  'Content-Type': 'application/json'
                }
              }
            ).then((response) => {
                this.refs = response.data
                var blockData = this.filterTradObject(this.refs.rows);
                if (blockData) {
                  this.emails = this.getEmailsFrom(blockData);
                }
            });
          } catch (error) {
                console.error(error);
          }
      },
      getShoppingCenters(session, country) {
        this.centerLoading = true;
        this.centers = [];
        this.selectedCenter = undefined;
        console.log('getShoppingCenters > country : ', country);
        try {
          axios.post(
              'https://cloud.email.westfield.com/translate_backend',
              {
                action: 'getSC',
                session: session,
                country: country
              },
              {
                headers: {
                  'Content-Type': 'application/json'
                }
              }
            ).then((response) => {
              this.centers = response.data.rows;
              if(this.centers === undefined) {
                console.log('getShoppingCenters > response error : ', response.data);
              }
              console.log('getShoppingCenters > centers : ', this.centers);
              this.centerLoading = false;
            });
        } catch (error) {
          console.error(error);
        }
      },
      getCountries(session, email) {
        this.countryLoading = true;
        this.countries = [];
        this.selectedCountry = undefined;
          console.log('getCountries > email : ', email);
          try {
            axios.post(
              'https://cloud.email.westfield.com/translate_backend',
              {
                action: 'getCountries',
                session: session,
                email: email
              },
              {
                headers: {
                  'Content-Type': 'application/json'
                }
              }
            ).then((response) => {
              var countriesData = response.data.rows;
              console.log('getCountries > countriesData : ', countriesData);

              var filteredData = [];
              for (var i = 0; i < countriesData.length; i++) {
                var item = countriesData[i];
                var filteredItem = {};
                for (var key in item) {
                  if (key === "country" || key === "country_name") {
                    filteredItem[key] = item[key];
                  }
                }
                filteredData.push(filteredItem);
              }
              console.log('getCountries > filteredData : ', filteredData);

              var uniqueData = [];
              var seenCountries = {};
              for (var i = 0; i < filteredData.length; i++) {
                var item = filteredData[i];
                if (!seenCountries[item.country]) {
                  uniqueData.push(item);
                  seenCountries[item.country] = true;
                }
              }
              this.countries = uniqueData;
              console.log('getCountries > countries : ', this.countries);
              this.countryLoading = false;
            });
          } catch (error) {
                console.error(error);
          }
      },
      getCountryType(session, country) {
        console.log('getCountryType > country : ', country);
        try {
          axios.post(
            'https://cloud.email.westfield.com/translate_backend',
            {
              action: 'getCountryType',
              session: session,
              country: country
            },
            {
              headers: {
                'Content-Type': 'application/json'
              }
            }
          ).then((response) => {
            console.log('getCountryType > res : ', response.data);
            if (response.data.rows.length > 0) {
              this.countryType = response.data.rows[0].type;
            }
            console.log('getCountryType > countryType : ', this.countryType);
          });
        } catch (error) {
              console.error(error);
        }
      },
      getHTML(blocks, index) {
        console.log('getHTML > blocks : ', blocks);
        try {
          if (index < blocks.length) {
            var snippet = blocks[index].snippet;
            var emailCode = blocks[index].email_code;
            var pcCode = blocks[index].pc_code;
            var country = blocks[index].country;
            console.log('getHTML > get : ',snippet);
            const parser = new DOMParser();

            axios.get('https://cloud.email.westfield.com/displayBlock?snippet='+snippet+'&pcCode='+pcCode+'&emailCode='+emailCode+'&country='+country+'&type='+this.type)
            .then((response) => {
              const doc = parser.parseFromString(response.data, 'text/html');
              const divBlock = doc.getElementById('block');
              if(divBlock) {
                blocks[index]["snippetHTML"] = divBlock.innerHTML;
              }
              this.getHTML(blocks, index+1);
            });
          } else {
            this.blocks = blocks;
            this.blockLoading = false;
          }
        } catch(error) {
          console.error(error);
          return '';
        }
      },
      getOneHTML(block) {
        console.log('getOneHTML > block : ', block);
        try {
            var snippet = block.snippet;
            var emailCode = block.email_code;
            var pcCode = block.pc_code;
            var country = block.country;
            console.log('getOneHTML > snippet : ',snippet);
            const parser = new DOMParser();

            axios.get('https://cloud.email.westfield.com/displayBlock?snippet='+snippet+'&pcCode='+pcCode+'&emailCode='+emailCode+'&country='+country+'&type='+this.type)
            .then((response) => {
              const doc = parser.parseFromString(response.data, 'text/html');
              const divBlock = doc.getElementById('block');
              if(divBlock) {
                this.draftSnippetHTML = divBlock.innerHTML;
              }
            });
        } catch(error) {
          console.error('getOneHTML > Error : ', error);
          return '';
        }
      },
      getBackToBlocks() {
        this.oneBlockEditing = false;
        this.selectedBlock = '';
        this.dataBlock = {};
        this.dataBlockKeys = {};
        this.saveOkMessage = '';
        this.saveErrorMessage = '';
      },
      getEmailPreview(session, email, country) {
        this.showPreview = false;
        console.log('getEmailPreview > email/country : ', email, '/', country);
        try {
          axios.post(
            'https://cloud.email.westfield.com/translate_backend',
            {
              action: 'getBlocks',
              session: session,
              email: email,
              country: country
            },
            {
              headers: {
                'Content-Type': 'application/json'
              }
            }
          ).then((response) => {
            var emailData = response.data.rows;
            this.emailPreview = emailData[0].picture_email;
            console.log('getEmailPreview > emailPreview picture : ', this.emailPreview);
            this.showPreview = true;
          });
        } catch (error) {
            console.error(error);
        }
      },
      hideEmailPreview() {
        this.showPreview = false;
      },
      validate() {
        console.log('validate > block: ', this.selectedBlock);
        this.showValidate = true;
        this.validationChecked = false;
      },
      cancelValidate() {
        this.showValidate = false;
        //this.validationChecked = false;
      },
      getBlocks(session, email, country, pcCode) {
        this.blockLoading = true;
        this.blocks = [];
        this.showPreview = false;
        this.emailPreview = '';
        console.log('getBlocks > entrée avec email / country : ', email, ' / ', country);
        try {
          axios.post(
            'https://cloud.email.westfield.com/translate_backend',
            {
              action: 'getBlocks',
              session: session,
              email: email,
              country: country
            },
            {
              headers: {
                'Content-Type': 'application/json'
              }
            }
          ).then((response) => {
            console.log('getBlocks > res : ', response.data);
            var blockData = response.data.rows;
            var blocks = [];
            for (var i = 0; i < blockData.length; i++) {
              var item = blockData[i];
              var filteredItem = {};
              for (var key in item) {
                if (key === "country" || key === "email_code" || key === "picture_email" || key === "block_label" || key === "block_name" || key === "snippet") {
                  filteredItem[key] = item[key];
                }
                filteredItem["pc_code"] = pcCode;
              }
              blocks.push(filteredItem);
            }
            console.log('getBlocks > sortie avec blocks : ', blocks);
            this.getHTML(blocks, 0);
          });
        } catch (error) {
            console.error(error);
            this.blocks = [];
        }
      },
      openBlock(session, block, country, center, email, type) {
        this.oneBlockEditing = true;
        this.oneBlockLoading = true;
        this.selectedBlockHTML = '';
        this.draftSnippetHTML = '';
        this.activeTab = 'live',
        this.currentBlock = block;
        this.formData = {};
        console.log('openBlock > block full Object : ', block);
        console.log('openBlock > block : ', block.block_name, ' / country : ', country, ' / center : ', center, ' / email : ', email, ' / type : ', type);
        var goodType = type;
        this.dataBlock = {};
        this.selectedBlock = block.block_name;
        this.selectedBlockHTML = block.snippetHTML;
        // Recover HTML from the draft version for this selected block
        var blockDraft = block;
        if(!block.snippet.endsWith('Draft')) {
          blockDraft.snippet = block.snippet+'Draft';
        }
        console.log('openBlock > blockDraft : ', blockDraft);
        this.getOneHTML(blockDraft);
        if (center !== 'all') {
          // Get type from this.centers, data used : rebranded
          for (var i=0; i<this.centers.length; i++) {
            if (center == this.centers[i].pc_code) {
              var typeBoolean = this.centers[i].rebranded;
              typeBoolean? goodType = 'branded':goodType = 'unbranded'
            }
          }
        }
        console.log('openBlock > translate_backend called with block : ', block.block_name, ' / country : ', country, ' / center : ', center, ' / email : ', email, ' / type : ', goodType);
        try {
          axios.post(
            'https://cloud.email.westfield.com/translate_backend',
            {
              action: 'openBlock',
              session: session,
              block: block,
              country: country,
              center: center,
              email: email,
              type: goodType
            },
            {
              headers: {
                'Content-Type': 'application/json'
              }
            }
          ).then((response) => {
            console.log('openBlock > res : ', response.data);
            var blocItems = {};
            var blocKeys = {};
            var blocDEKeys = {};
            var item = response.data.row;
            /* HARDCODED !! */
            const keyValues = ['country', 'mail', 'type', 'pc_code'];
            for (var key in item) {
              if (keyValues.includes(key)) {
                var newKey = key;
                if (key == 'pc_code') { newKey = 'shopping center' }
                if (key == 'mail') { newKey = 'email code' }
                blocKeys[newKey] = item[key];
                blocDEKeys[key] = item[key];
              } else if (this.condition(key)) {
                blocItems[key] = item[key];
              }
            }
            this.dataBlock = blocItems;
            this.dataBlockKeys = blocKeys;
            this.dataBlockDEKeys = blocDEKeys;
            this.blockLabel = block.block_label;
            for (const key in this.dataBlock) {
              this.formData[key] = this.dataBlock[key];
            }
            this.oneBlockLoading = false;
          });
        } catch (error) {
            console.error(error);
            this.dataBlock = {};
        }
      },
      saveTradDraft(session) {
        this.saveOkMessage = '';
        this.saveErrorMessage = '';
        console.log('saveTradDraft > new form data: ', this.formData);
        var keys_columns = Object.keys(this.dataBlockDEKeys);
        var keys_values = Object.values(this.dataBlockDEKeys);
        var data_columns = Object.keys(this.formData);
        var data_values = Object.values(this.formData);
        console.log('saveTradDraft > all params for backend => keys_columns/keys_values/data_columns/data_values/block : ',keys_columns,'/', keys_values,'/', data_columns,'/', data_values,'/', this.selectedBlock);
        try {
          axios.post(
            'https://cloud.email.westfield.com/translate_backend',
            {
              action: 'saveTradDraft',
              session: session,
              keys_columns: keys_columns,
              keys_values: keys_values,
              data_columns: data_columns,
              data_values: data_values,
              block: this.selectedBlock
            },
            {
              headers: {
                'Content-Type': 'application/json;charset=UTF-8'
              }
            }
          ).then((response) => {
            console.log('saveTradDraft > Save response: ', response.data);
            if (response.data.callback == 1) {
              this.saveOkMessage = 'Draft version updated successfully!';
              // Reload the full block (live and draft version)
              this.openBlock(session, this.currentBlock, this.selectedCountry, this.selectedCenter, this.selectedEmail, this.type)
              this.activeTab ='draft';
            } else {
              this.saveErrorMessage = 'A technical issue has occured!';
            }
          });
        } catch (error) {
            console.error('saveTradDraft > Error: ', error);
        }
      },
      resetTrad(session) {
        console.log('resetTrad > Block: ', this.selectedBlock);
        var keys_columns = Object.keys(this.dataBlockDEKeys);
        var keys_values = Object.values(this.dataBlockDEKeys);
        var data_columns = Object.keys(this.formData);
        console.log('resetTrad > keys/values/data_keys: ',keys_columns,'/',keys_values,'/',data_columns);
        try {
          axios.post(
            'https://cloud.email.westfield.com/translate_backend',
            {
              action: 'resetTrad',
              session: session,
              keys_columns: keys_columns,
              keys_values: keys_values,
              data_columns: data_columns,
              block: this.selectedBlock
            },
            {
              headers: {
                'Content-Type': 'application/json;charset=UTF-8'
              }
            }
          ).then((response) => {
            console.log('resetTrad > response: ', response.data);
            if (response.data.callback == 1) {
              this.saveOkMessage = 'Draft version reset successfully!';
              // Reload the full block (live and draft version)
              this.openBlock(session, this.currentBlock, this.selectedCountry, this.selectedCenter, this.selectedEmail, this.type)
              this.activeTab ='draft';
            } else {
              this.saveErrorMessage = 'A technical issue has occured!';
            }
          });
        } catch (error) {
            console.error('resetTrad > Error: ', error);
        }
      },
      isTextarea(key) {
        return this.dataBlock[key].length > 50;
      },
      filterTradDE(res) {
        console.log('filterTradDE');
        const resProd = res.rows;
        const resDraft = res.fields;
        console.log('filterTradDE > resDraft : ', resDraft);
        console.log('filterTradDE > resProd : ', resProd);
        let newRes = [];
        if (resProd !== undefined) {
            for (let i=0; i<resProd.length; i++) {
                let draftArray = Object.keys(this.filterTradObject(resDraft[0]));
                console.log('filterTradDE > draft keys array : ', draftArray);
                let el = this.reduceTradObject(resProd[i], draftArray);
                console.log('filterTradDE > element filtered : ', el);
                newRes[i] = el;
            }
            return newRes;
        } else return [];
      },
      reduceTradObject(obj, arr) {
          console.log('reduceTradObject');
          return Object.fromEntries(Object.entries(obj).filter(([key, val]) => arr.includes(key)));
      },
      filterTradObject(obj) {
          console.log('filterTradObject');
          if (obj && typeof obj === "object") {
          return Object.entries(obj).filter(([key, val]) => this.condition(key)).map(([key, val]) => val);
          } else return []
      },
      condition(key) {
          if (key !== 'snippetHTML' && !key.startsWith('_') && !key.startsWith('url_') && !key.startsWith('ctaurl_') && !key.startsWith('ctaUrl_') && !key.startsWith('image_') && !key.endsWith('_url') && !key.endsWith('_link') && !key.includes('_image')) {
              return true
          } else return false;
      },
      getTrad(session, de, country) {
          try {
              axios.post(
                'https://cloud.email.westfield.com/translate_backend',
                {
                  action: 'getTrad',
                  inputDE: de,
                  country,
                  session
                },
                {
                  headers: {
                    'Content-Type': 'application/json'
                  }
                }
              ).then((response) => {
                  this.trads = this.filterTradDE(response.data)
              });
              
          } catch (error) {
              console.error(error);
          }
      },
      getTradHeader(session) {
          console.log('getTradHeader > session : ', session);
          try {
              axios.post(
                'https://cloud.email.westfield.com/translate_backend',
                {
                  action: 'tradHeader',
                  session: session
                },
                {
                  headers: {
                    'Content-Type': 'application/json'
                  }
                }
              ).then((response) => {
                  this.trads = this.filterTradDE(response.data)
                  console.log('getTradHeader > response message : ', response.data.message);
                  console.log('getTradHeader > response data rows : ', response.data.rows);
                  console.log('getTradHeader > trads filtered : ', this.trads);
              });
              
            } catch (error) {
                  console.error(error);
            }
      }
    }
  ,
    
  })
  .mount("#app");