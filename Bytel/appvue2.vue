const { createApp, ref } = Vue


createApp({
  setup () {
 const messageAdmin = ref('En cours...')
 const fondMessageAdmin = ref('text-gray-500 text-center text-xs mt-2')
 const loadedAdmin = ref(false)
 const refreshTextAdmin = ref('Refresh')

 const messageMkt = ref('En cours...')
 const fondMessageMkt = ref('text-gray-500 text-center text-xs mt-2')
 const loadedMkt = ref(false)
 const refreshTextMkt = ref('Refresh')


 const messagePrsp = ref('En cours...')
 const fondMessagePrsp = ref('text-gray-500 text-center text-xs mt-2')
 const loadedPrsp = ref(false)
 const refreshTextPrsp  = ref('Refresh')


 const messageAPIInt = ref('En cours...')
 const fondMessageAPIInt = ref('text-gray-500 text-center text-xs mt-2')
 const loadedAPIInt = ref(false)
 const refreshTextAPIInt  = ref('Refresh')


 const messageAPIExt = ref('En cours...')
 const fondMessageAPIExt = ref('text-gray-500 text-center text-xs mt-2')
 const loadedAPIExt = ref(false)
 const refreshTextAPIExt  = ref('Refresh')


 const messageAll = ref('')
 const fondMessageAll = ref('text-green-500 text-center text-xs mt-2')
 const loadedAll = ref(true)

 const activeAdmin = ref(true)
 const activeP1 = ref(true)
 const activeP2 = ref(false)
 const activeMkt = ref(false)
 const activePrsp = ref(false)
 const activeAPIInt = ref(false)
 const activeAPIExt = ref(false)
 const checkImportDonneesSocle = ref('')
 const dateAdmin = ref('...')
 const dateMkt = ref('...')
 const datePrsp = ref('...')
 const dateAPIInt = ref('...')
 const dateAPIExt = ref('...')
 const resAdmin = ref({})
 const resP1 = ref({})
 const resP2 = ref({})
 const resMkt = ref({})
 const resPrsp = ref({})
 const resAPIInt = ref({})
 const resAPIExt = ref({})
 
 const refreshALLText = ref('Refresh All BUs')
 const refreshALLClass = ref('bg-gray-400 hover:bg-gray-400 text-white font-bold py-2 px-14 rounded')


 const active = ref('border-blue-500 bg-blue-500 text-white')
 const notactive = ref('border-white text-blue-500 hover:bg-blue-200 cursor-pointer')

 const activeCriticite = ref('border-green-500 bg-green-500 text-white')
 const notactiveCriticite = ref('border-white text-green-500 hover:bg-green-200 cursor-pointer')

function parseDate(dateString) {
  const dateParts = dateString.match(/(\d{1,2}) (\w{3}) (\d{4}) (\d{2}):(\d{2}):(\d{2})/);
  if (dateParts) {
    const monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    const day = parseInt(dateParts[1]);
    const month = monthNames.indexOf(dateParts[2]);
    const year = parseInt(dateParts[3]);
    const hours = parseInt(dateParts[4]);
    const minutes = parseInt(dateParts[5]);
    const seconds = parseInt(dateParts[6]);
    return new Date(year, month, day, hours, minutes, seconds);
  } else {
    return null; // Return null for invalid date strings
  }
}

function DATAMKT3484CheckImportDonneesSocle(data) {
  const lineToCheck = data.find(item => item.name === 'Import Donnees Socle');

  if (lineToCheck) {
    const automationLastRunDate = parseDate(lineToCheck.statusInstance.AutomationLastRun.dateFin);
    const n1Date = parseDate(lineToCheck.statusInstance.AutomationPreviousRuns.N1.dateFin);
    const n2Date = parseDate(lineToCheck.statusInstance.AutomationPreviousRuns.N2.dateFin);
    const n3Date = parseDate(lineToCheck.statusInstance.AutomationPreviousRuns.N3.dateFin);
    const n4Date = parseDate(lineToCheck.statusInstance.AutomationPreviousRuns.N4.dateFin);
    const n5Date = parseDate(lineToCheck.statusInstance.AutomationPreviousRuns.N5.dateFin);

    if (automationLastRunDate.getHours() >= 20) {
      if  ( ! (
        automationLastRunDate.toDateString() === n1Date.toDateString() &&
        n2Date.toDateString() === n3Date.toDateString() &&
        n3Date.getDate() === automationLastRunDate.getDate() - 1 &&
        n4Date.toDateString() === n5Date.toDateString() &&
        n4Date.getDate() === automationLastRunDate.getDate() - 1
      ) ) {
        return 'bg-red-200';
      }
    } else {
      if ( ! (
        n1Date.toDateString() === n2Date.toDateString() &&
        n1Date.getDate() === automationLastRunDate.getDate() - 1 &&
        n3Date.toDateString() === n4Date.toDateString() &&
        n3Date.getDate() === n2Date.getDate() - 1 &&
        n5Date.getDate() === n4Date.getDate() - 1
      ) ) {
        return 'bg-red-200';
      }
    }
  }

  return '';
}

 const dateCourante = () => {
  const today = new Date();
  const month = ((today.getMonth() + 1) < 10 ? '0' : '') + (today.getMonth() + 1);
  const date = (today.getDate() < 10 ? '0' : '') + today.getDate() + '/' + month;
  let minutes = today.getMinutes();
  minutes = minutes <= 9 ? '0' + minutes : minutes;
  const time = today.getHours() + "h" + minutes;
  return 'Le '+date+' à '+ time;
 }
 const getStatus = (MID, mode,criticite='P1') => {
    var valueTestResult =  testResult(MID,criticite);
  if (mode == 'lazy') {
   majActiveFlag(MID,criticite);
   if(!valueTestResult){
    return { success: true };
   }
   
  }
  if (mode == 'refresh' || (mode == 'lazy' && valueTestResult )) {
   switch (MID) {
    case 7211327:
        loadedAdmin.value = false;
        messageAdmin.value = 'En cours...';
        fondMessageAdmin.value = 'text-gray-500 text-center text-xs mt-2';
        refreshTextAdmin.value = '<i class="fas fa-spinner fa-pulse"></i>'
      break;
    case 7213695:
        loadedMkt.value = false;
        messageMkt.value = 'En cours...';
        fondMessageMkt.value = 'text-gray-500 text-center text-xs mt-2';
        refreshTextMkt.value = '<i class="fas fa-spinner fa-pulse"></i>'
      break;
    case 7226728:
        loadedPrsp.value = false;
        messagePrsp.value = 'En cours...';
        fondMessagePrsp.value = 'text-gray-500 text-center text-xs mt-2';
        refreshTextPrsp.value = '<i class="fas fa-spinner fa-pulse"></i>'
      break;
    case 7310020:
        loadedAPIInt.value = false;
        messageAPIInt.value = 'En cours...';
        fondMessageAPIInt.value = 'text-gray-500 text-center text-xs mt-2';
        refreshTextAPIInt.value = '<i class="fas fa-spinner fa-pulse"></i>'
      break;
    case 7310019:
        loadedAPIExt.value = false;
        messageAPIExt.value = 'En cours...';
        fondMessageAPIExt.value = 'text-gray-500 text-center text-xs mt-2';
        refreshTextAPIExt.value = '<i class="fas fa-spinner fa-pulse"></i>'
      break;
  }
   
   //console.log('getStatus refresh');
   resetResult(MID,criticite);
   return axios.get('https://site.infos.xxxxxx.fr/automationSupervisionHandler?MID='+MID+'&Criticite='+criticite)
   .then(response => {
    getResult(MID, response,criticite);
    switch (MID) {
        case 7211327:
            loadedAdmin.value = true;
            messageAdmin.value = 'Mise à jour : '+dateCourante();
            fondMessageAdmin.value = 'text-green-500 text-center text-xs mt-2';
            refreshTextAdmin.value = 'Refresh'
          break;
        case 7213695:
            loadedMkt.value = true;
            messageMkt.value = 'Mise à jour : '+dateCourante();
            fondMessageMkt.value = 'text-green-500 text-center text-xs mt-2';
            refreshTextMkt.value = 'Refresh'
          break;
        case 7226728:
            loadedPrsp.value = true;
            messagePrsp.value = 'Mise à jour : '+dateCourante();
            fondMessagePrsp.value = 'text-green-500 text-center text-xs mt-2';
            refreshTextPrsp.value = 'Refresh'
          break;
        case 7310020:
            loadedAPIInt.value = true;
            messageAPIInt.value = 'Mise à jour : '+dateCourante();
            fondMessageAPIInt.value = 'text-green-500 text-center text-xs mt-2';
            refreshTextAPIInt.value = 'Refresh'
          break;
        case 7310019:
            loadedAPIExt.value = true;
            messageAPIExt.value = 'Mise à jour : '+dateCourante();
            fondMessageAPIExt.value = 'text-green-500 text-center text-xs mt-2';
            refreshTextAPIExt.value = 'Refresh'
          break;
      }

   
   })
  }

 }
  const getAllBUsStatus = () => {
    loadedAll.value = false;
    messageAll.value = 'En cours...';
    fondMessageAll.value = 'text-gray-500 text-center text-xs mt-2';
    refreshALLText.value = '<i class="fas fa-spinner fa-pulse"></i>'
    Promise.all([getStatus(7211327, 'refresh'),getStatus(7211327, 'refresh','P2'), getStatus(7213695, 'refresh'), getStatus(7226728, 'refresh'),getStatus(7310020, 'refresh'), getStatus(7310019, 'refresh')])
    .then(function(values) {
        loadedAll.value = true;
        messageAll.value = 'Mise à jour : '+dateCourante();
        fondMessageAll.value = 'text-green-500 text-center text-xs mt-2';
        refreshALLText.value = 'Refresh All BUs';
      });


 }  
   
 const iconFrom = (status) => {
  if (status == 'Complete') {
   return '<i class="text-green-600 fa-solid fa-circle-check fa-xl">&nbsp;</i>'
  }
  if (status == 'Error') {
   return '<i class="text-red-600 fa-solid fa-triangle-exclamation fa-xl">&nbsp;</i>'
  }
  if (status == 'Executing') {
   return '<i class="text-cyan-900 fa-solid fa-spinner fa-pulse fa-xl">&nbsp;</i>'
  }
  if (status == 'Stopped') {
   return '<i class="text-yellow-400 fa-solid fa-triangle-exclamation fa-xl">&nbsp;</i>'
  }
 }
 const majActiveFlag = (MID,criticite='P1') => {
  if (MID == 7211327) {
   activeAdmin.value = true;
   if (criticite=='P1'){
    activeP1.value = true;
    activeP2.value = false;
    }
    else{
    activeP1.value = false;
    activeP2.value = true;
    }
   activeMkt.value = activePrsp.value = activeAPIInt.value = activeAPIExt.value = false;
  }
  if (MID == 7213695) {
   activeMkt.value = true;
   activeP1.value = activeP2.value = activeAdmin.value = activePrsp.value = activeAPIInt.value = activeAPIExt.value = false;
  }
  if (MID == 7226728) {
   activePrsp.value = true;
   activeP1.value = activeP2.value =  activeMkt.value = activeAdmin.value = activeAPIInt.value = activeAPIExt.value = false;
  }
  if (MID == 7310020) {
   activeAPIInt.value = true;
   activeP1.value = activeP2.value = activeMkt.value = activePrsp.value = activeAdmin.value = activeAPIExt.value = false;
  }
  if (MID == 7310019) {
   activeAPIExt.value = true;
   activeP1.value = activeP2.value = activeMkt.value = activePrsp.value = activeAPIInt.value = activeAdmin.value = false;
  }
 }
 const getResult = (MID, response,criticite='P1') => {
  if (MID == 7211327) {
      if (criticite=='P1'){
    resP1.value = response.data;
    checkImportDonneesSocle.value = DATAMKT3484CheckImportDonneesSocle(resP1.value);
    }
    else{
    resP2.value = response.data;
    }
   dateAdmin.value = dateCourante();
  }
  if (MID == 7213695) {
   resMkt.value = response.data;
   dateMkt.value = dateCourante();
  }
  if (MID == 7226728) {
   resPrsp.value = response.data;
   datePrsp.value = dateCourante();
  }
  if (MID == 7310020) {
   resAPIInt.value = response.data;
   dateAPIInt.value = dateCourante();
  }
  if (MID == 7310019) {
   resAPIExt.value = response.data;
   dateAPIExt.value = dateCourante();
  }
 }
 const testResult = (MID,criticite='P1') => {
  if (MID == 7211327) {
          if (criticite=='P1'){
   return Object.keys(resP1.value).length === 0;
    }
    else{
    return Object.keys(resP2.value).length === 0;
    }
  }
  if (MID == 7213695) {
   return Object.keys(resMkt.value).length === 0;
  }
  if (MID == 7226728) {
   return Object.keys(resPrsp.value).length === 0;
  }
  if (MID == 7310020) {
   return Object.keys(resAPIInt.value).length === 0;
  }
  if (MID == 7310019) {
   return Object.keys(resAPIExt.value).length === 0;
  }
 }
 const resetResult = (MID,criticite='P1') => {
  if (MID == 7211327) {
             if (criticite=='P1'){
    resP1.value = {}
    checkImportDonneesSocle.value = ''
    }
    else{
     resP2.value = {}
   
    }  
   
   dateAdmin.value = '...'
  }
  if (MID == 7213695) {
   resMkt.value = {}
   dateMkt.value = '...'
  }
  if (MID == 7226728) {
   resPrsp.value = {}
   datePrsp.value = '...'
  }
  if (MID == 7310020) {
   resAPIInt.value = {}
   dateAPIInt.value = '...'
  }
  if (MID == 7310019) {
   resAPIExt.value = {}
   dateAPIExt.value = '...'
  }
 }
 
 refreshTextAdmin.value = '<i class="fas fa-spinner fa-pulse"></i>'
 refreshALLText.value = 'Refresh All BUs'
  refreshALLClass.value = 'bg-gray-400 hover:bg-gray-400 text-white font-bold py-2 px-14 rounded'

   
 // INIT call BU Admin P1
 axios.get('https://site.infos.xxxxxx.fr/automationSupervisionHandler?MID=7211327&Criticite=P1')
 .then(response => {
  resP1.value = response.data
  loadedAdmin.value = true
  messageAdmin.value = 'Mise à jour : '+dateCourante();
  dateAdmin.value = dateCourante()
  fondMessageAdmin.value = 'text-green-500 text-center text-xs mt-2'
  refreshTextAdmin.value = 'Refresh'
  refreshALLText.value = 'Refresh All BUs'
  refreshALLClass.value = 'bg-blue-900 hover:bg-blue-800 text-white font-bold py-2 px-14 rounded'
  checkImportDonneesSocle.value = DATAMKT3484CheckImportDonneesSocle(resP1.value);
 });
   
 return { messageAll,messageAdmin,messageMkt,messagePrsp,messageAPIInt,messageAPIExt, refreshTextAdmin,refreshTextMkt,refreshTextPrsp,refreshTextAPIExt,refreshTextAPIInt,refreshALLText, resAdmin, resMkt, resPrsp, resAPIInt, resAPIExt, loadedAdmin,refreshALLClass,resP1,resP2,
    loadedMkt,loadedAll,loadedPrsp,loadedAPIInt,loadedAPIExt, getStatus,getAllBUsStatus, fondMessageAdmin,fondMessageMkt,fondMessageAll,fondMessagePrsp,fondMessageAPIInt,fondMessageAPIExt, dateAdmin, dateMkt, checkImportDonneesSocle ,
  datePrsp, dateAPIInt, dateAPIExt, activeAdmin, activeMkt, activePrsp, activeAPIInt, activeAPIExt, active, notactive, iconFrom,activeP1,activeP2,activeCriticite,notactiveCriticite };
}}).mount('#app');